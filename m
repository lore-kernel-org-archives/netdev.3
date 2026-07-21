Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55C367B92
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784598213; cv=none; b=g2GpL+NngH89deoDfVOG9Bf3eeXLN559RGrJ8ZRz0kz+nViLude6rwFZApUzJvj2kJPK0q1iUpdCfUFix5WiMgF1f62601x5IuKznJAlQ3H7gkVyREh58gNcLZKyE0k/DzMrz5x2NfZQN1e8AF2TI7mrwqmBqEPKm85nkNZID90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784598213; c=relaxed/simple;
	bh=retvUfSOUd26BqgItd9q2ItJ/FH/wrxC7/sDXqPoxe0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cCIVjCzn69XnJW7U8P0GDDFQhKMjV9/YsZ84zthQzjK/RYnx0SyoyvKnncEv+cACS/LMsLzOMkTFgpdxqm0jsoemOuEJWwudokjEQUyTyduuGMfDqaepK/XsF/IVUv5CvLKnBSdZvdhgWaxETCcU7OqSqQp39H4aHhnY+v1kYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=AMSmDieQ; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="AMSmDieQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1784598202; x=1784857402;
	bh=retvUfSOUd26BqgItd9q2ItJ/FH/wrxC7/sDXqPoxe0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AMSmDieQiOOEL9A5PhfriE4nn4esy0Ee+1cPvqpg1YVqln1wUHlL71YvQ3UwBvSmp
	 DI7Wf8jOYOIt4fGiDzFg+xTfEetN1AXs2LebFN21oUrT+ISPx9c7HIivatYraeXYNH
	 PWcVRpakL3qQ80SdYz+yyEz9a0Oiv3g3R/K3kbm6jIIggEw1cIs6QCnBwzS6yamUMg
	 qyNFY0lR1vtg6h20MRI6FqSC/ZCbQQetqFvHh9otdnWKS9cic69Su7AkzKc5utabPZ
	 8+ceAs2CbJyI6W8x0d8UxWlNUeS9J7ZaRoIr9U5wE94sI+g3kA1y0ejIH3+i7fYIVa
	 uPvwVnXKKZJFA==
Date: Tue, 21 Jul 2026 01:43:15 +0000
To: netdev@vger.kernel.org
From: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] tun: prevent underflow in rx headroom calculation
Message-ID: <20260721014117.2234892-1-manizada@pm.me>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: a12772ccdb9595134092de6a5fec099e05698102
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

tun_get_user() calculates good_linear with SKB_MAX_HEAD(align). The align
value comes from ndo_set_rx_headroom() and can be larger than the linear
space available in a one-page skb head.

OVS can reach this case by carrying headroom from a netkit/VXLAN port to a
TUN port. SKB_MAX_HEAD() then underflows, leaving good_linear negative.
Assigning that value to the size_t linear variable in tun_get_user()
converts it to a large positive value. The wrapped value is passed to
tun_alloc_skb(), where prepad + linear and len - linear wrap. skb->data can
then end up past the allocated head, and later packet processing can access
memory outside the skb.

Clamp good_linear to zero when SKB_MAX_HEAD() returns a negative value.
This lets tun_alloc_skb() allocate the requested headroom and place the
packet data linearly or in fragments without wrapping.

Fixes: eaea34b23c46 ("net/tun: implement ndo_set_rx_headroom")
Cc: stable@vger.kernel.org
Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
---
 drivers/net/tun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index ffbe6f13fb1..d3be0f2d5df 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1780,6 +1780,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, s=
truct tun_file *tfile,
 =09}
=20
 =09good_linear =3D SKB_MAX_HEAD(align);
+=09good_linear =3D max(good_linear, 0);
=20
 =09if (msg_control) {
 =09=09struct iov_iter i =3D *from;
--=20
2.39.5


