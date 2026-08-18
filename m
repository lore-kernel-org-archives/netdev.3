Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1531843B4B2
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042806; cv=none; b=AWhAbkNDXRkrEykHFmHVwKkhhOZdTCuodzKRsud5X05hjXNKdbajx89fQP1tCF2pbWPS+Vd3GxqFnz1u4I7dgetGcmSO0HRniHoqsWXRHN7qhF2OVh9Lh3r+UlLciwst8/S29kLhFZYgmN8YqNGdQEvs+MYrwaoXv0MuHfNg95I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042806; c=relaxed/simple;
	bh=GF6Hd3Wu9d+8+v1Ikb5K7KWhUHhKY0lsI7cCBM13xgE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Cdk1IEl/PLkbW69yhCcpcamotm8TbZJHYtnVpxCDlu6gqZRG9W68CHNEsBK26jvy1RTfBJbMAIet18gXpdcki5CMUf9XzGmexviIxScDRjroFqVR+CirTLJZYpoxy7BroGORYOpmWh3jgJjiBf91iHzF7nXQE3ufLdZ9uxgmn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=PzejMekq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="PzejMekq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso43468115e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1787042802; x=1787647602; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8MlFAE89dEyHP879JePBDi2+i6NFCJ7ZsUV+zmtCqYo=;
        b=PzejMekqjwnk05Fr6dSZlEeQp2cwK5qsQyUiRjitGCwIaZLD8EA7/LJwq5EBlEG0tF
         3n/bvdDUGO6zTwkdw6BWzpj23rzGzXCV0wHskG5NEFgC5Z4E5Z8WYfnfBniZ+qEKcm+q
         4VryrRYLAdjH/pO/GuuDwncdk/oWBJRNEpul3pxbAqZfy7UtdV2eu+soGx+u7R9LxUgh
         VP1fWxsM5JpO7mbg7tPO6McIBTSUgM2L7BtGAq4Sxu+zm4IE5jGjz2SJCISRbIhrW0N/
         R2UEl3pwt+SbMm+AR8UEppLTN0HbfhPUD8RDrMJyjogUuUVMUGAFuQI3iw4PPeDgyUTM
         NTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787042802; x=1787647602;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8MlFAE89dEyHP879JePBDi2+i6NFCJ7ZsUV+zmtCqYo=;
        b=qxf/AWZdgbtHIa0xhfvebsf6Pcb2lOSla/FohAIPCg0A1WxvLkCn58FhPko0dQhwZQ
         rDqIDssINwesnaS6m4AsfUGkwYA/w9Nf2SQyIMftowLG6YgwoAOXUGhlPwQa6wV8HQ78
         WMkQcDiu+nJkySDILt0D1MXKbMQI2vgo6jOIn6y1BsUj6k0RJWcw3dC0j+RVRu1XXA07
         ZGyi918FSQIO2Ohy/LSIRvOMn1GGFWrEfNxsLfYbQolhs1IXssjUhNCSFFas34wHMfCi
         NifEXcXl7PLWRcYGLM+CtiIuSHTynQNyZcWxyN/KmfJ3It8dQ6VDCjLPsjgIFGL7Dl7s
         M3aQ==
X-Gm-Message-State: AOJu0YyIOMPMvzjjngAInULuTQpl8kn+raGUyPLSttGFIZGs2cmfMfp2
	fFzpksSZa+JGopniS4OXfLCC8Y/uV6JEhiW+Q5tytAf+brJeu3EnQLtCcl0hGx/8vB82t8C8mSF
	niDwKpIB5sg==
X-Gm-Gg: AR+sD13YPfIuAvAhkmYBvlPbhprcukcPc1B0jzFz9iVEzDlkHXwa14gdkdRYh6jV5+Y
	pD2ar/a1KY3sbhboeMtVOh4eopv52nwEGoNgR3IK8095LfU9cJ+S/BjdeLGaMJxCnwD+FpcGqhk
	oo3xDRDG1WCiay6HDTUL3/U6wIi6is25DqlCtrh1gpA90hdJDy+k8JWJx47SqLvW8y+oMHlxc44
	solRCmfhJca/e135f8P86ZmEcBXAXL0kAEYDnmKWu4dBF937zsLmpcW8SW0cFNo6BPAm355iF2l
	gfU62nQRA45886DuOZDAN8znKS+Ik6t+xzI+nnsYxCruYhUPWdFMISqrRbgqcnGnQzjweO6r5oV
	a2uyvh7P5NaixmM97fnaTM4+B982Se7gzwLIoa+SevLOnQOl+PEVhY9yycDjJaBzi9pefhDj83O
	EVPEBSPv1xGGmxQY1PtzgyltyJUPeHXSiTnTtJjgAxothZFMiaeALk6gnmcsxWWr995Zt4kEoY/
	UJNAVKEiwtXlpCOqaweSkK/JL6idWIqpi4uKZ8PajxyO9PQjOgjzZaKEGkO+3cdBpCP4SUmm5ff
	nfUHxaPYv7a7yffbdhA+6Q==
X-Received: by 2002:a05:600d:10e:b0:495:4572:21af with SMTP id 5b1f17b1804b1-499879809b7mr341093675e9.9.1787042801837;
        Tue, 18 Aug 2026 01:46:41 -0700 (PDT)
Received: from smtpclient.apple (78-141-71-213.dynamic.orange.sk. [78.141.71.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d086c6dsm109435105e9.7.2026.08.18.01.46.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2026 01:46:41 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net v3 2/3] net: skbuff: don't skb_tx_error() the source skb
 in skb_zerocopy()
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
Date: Tue, 18 Aug 2026 10:46:29 +0200
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org,
 dev@openvswitch.org,
 Jongmin Jang <payload.jang@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C93E6967-0109-4245-8A6C-7DAE4CDBB6BA@doyensec.com>
References: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

skb_zerocopy() copies frags from @from into @to. On an
skb_orphan_frags() failure it calls skb_tx_error(@from), a destructive
operation on the source skb the copy helper does not own. That completes
@from's zerocopy uarg and clears SKBFL_ALL_ZEROCOPY, including the
SKBFL_SHARED_FRAG page-ownership marker.

Both callers already report the failure on their own drop path.
nfnetlink_queue does it at nla_put_failure, and Open vSwitch does it in
the flow-miss drop arm of ovs_dp_process_packet(), so nothing is lost by
dropping it here.

On Open vSwitch's OVS_ACTION_ATTR_USERSPACE path the skb is not freed on
this error: do_execute_actions() ignores output_userspace()'s return
value and, unless the upcall was the last action, keeps forwarding the
same skb through the flow's remaining actions. The uarg is completed
while that skb is still in flight, telling the producer its buffers are
free, and SKBFL_SHARED_FRAG is cleared on an skb the rest of the stack
still handles. That flag is what makes esp_input() call skb_cow_data()
instead of decrypting in place, so a later local ESP delivery can
decrypt over frags the skb does not own privately.

Leave error reporting to the callers.

Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in =
skb_zerocopy and handle errors")
Cc: stable@vger.kernel.org
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/core/skbuff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ba3dbac80fb4..db62ed6e04b9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3907,10 +3907,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff =
*from, int len, int hlen)
=20
 	skb_len_add(to, len + plen);
=20
-	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC))) {
-		skb_tx_error(from);
+	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC)))
 		return -ENOMEM;
-	}
+
 	skb_zerocopy_clone(to, from, GFP_ATOMIC);
=20
 	for (i =3D 0; i < skb_shinfo(from)->nr_frags; i++) {
--=20
2.55.0

