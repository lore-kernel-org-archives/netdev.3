Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8F35A925
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786600163; cv=none; b=ZhXiGWFZjO/NNl1EUJY8O9fsyjBmR7zMXRiu8ILauM5fFgEUtmZPfMA27Ahykgd19jREsFMJloBm0KT7IRK/n9RJh65vfdCoaeO2eO8tnKYmMusF/Wf+6d76W5IkYNktfNQikIm2lkzOvhtPJRZUky/Ht5DiEpuQSeOFd/JXqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786600163; c=relaxed/simple;
	bh=DD4x9dHkGU4cDjR/mJvI8MDyrTRsx7GHOme7uBSE0Mo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=egF/RWdSAGmh5McNpVxPAXkBbxpbGpO3hnvO4MG9TmoViAl7wF2nVPrqpbYHlxiRbwJxXlF1gISyh1FBPpAWV/6R9y6a7GZspV16oBaFgXlOyZgnhvnQCoMofjidW4XG3OrGFdjdEsfGHxpQEMovY16xRIegpcloHS3/fT358Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=lyGmHxrv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="lyGmHxrv"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso15633025e9.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 22:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1786600158; x=1787204958; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qcj67/iZbPVnPwuEzD5gleo+X9KFc46I9KgcY3Q6BDw=;
        b=lyGmHxrvsZ1dl1SgJYfw8gzy4B7SNriClPvZRRwxbNlcTN4MvzQ7CKcwk0g36DjFi9
         r0lASKMSRRpxrzvlAPCXXMebsSJMj5EdLh56j+3GaYmsYTJtxB4bdR5FguyXvK4c2/Ou
         Hks85O5i30ZBUrGwwVhw7lBnFOs/X6DI9qePDjozyWb1HhjZPCF3K4wyWuUE/btzwtx7
         GHooXbpuC18KHHL99UfRWyuOrJpjpzN6x5pZ4+D+iTj97A24DTQBdEhVApBUeKO4S2Ew
         nwZ7x7QvVB0GvlfFf3cGzZIKeMlVk5YSczRJgWJM6u/vEFvPPlx9okaEKPUeGlMO5pAO
         13UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786600158; x=1787204958;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qcj67/iZbPVnPwuEzD5gleo+X9KFc46I9KgcY3Q6BDw=;
        b=Yn3datlnxmxnKly387ebA1ofMwtr2kwO7l6GMnO8/IliwRdDorhIVuXqHw36tdhqsT
         uL8UMP4n9iOEMZYq6GdTTpGmtF/F0XyourPCdhtSPPsWGAeeHWY46kxO/n1TXEBN+6oy
         qHzeEyqJKlzmwAHKLseIHto9u6Lm4hlo3w4Nt31zO7Q8l3Ai7ZYBkiP4ebaHAWS3RSjN
         6gy7N7WYvDRuDB0sFuy8ql2NrAV02fx+tndx/cMOxyVhyeKBRA6EIULtCl7deVDlB+c+
         E2n+04bapJwqxDEXtvDIRnO0avSaIvcDPvlLFuNNesTsDwydtewybFL1XKd27Rkjq5dT
         3I0A==
X-Gm-Message-State: AOJu0YzwSK+yzsTQ7c8yw3K/2nSIbnWmlrvGWHFfW9ncv7BPNXdIKS1/
	xUXca8Ga7+ColJw9v7pwT6COQN4g+FO9Dsv/P9771Ub4Lexk7kxU2R1OFKZ4fb3pHZFPPDRrXrZ
	MJxbsq28YWQ==
X-Gm-Gg: AR+sD12tNuidvvTlSH18ChxR3w/zzVYHLwYoiKAscu01ieGQ//7qbszezrhd5ZxNBN/
	Ml/azdlCL2IiEl8Bks4aiSJ8Qyrt1hw+kwwcRxHcRcDcTA8jh6ku8fR7Nrd8fPj+sfAe+9bTSca
	eiPHH9O72C8wHhKNzcpJrDaSXSbr33Td04Wr+0nm2xs1/iDI8ye3/qblxkq3QOCLrfcms3Bayem
	vdPosrpJSnZ1FXBiDYRZsILcjwqTYiOiKI+zT51syeKzZ0f+3OOm641AVrcaGtuZlOCa/C5jCvS
	YN6KZZKQpcPiuOVexp0UwbRT8nCYjGQVfxGj1G0ZMqdIfiw9p3vw3HOZOKDpLzXo/79iw80XO+L
	lTL2cbyuhJX8Et1wKhvNl6U9Dtva6EMaTOEcf1PnVmYuoJrp8Kojd1//mgp5sv+cLUiz0g5dod6
	Zf5z0AJd1E6Pq4CnT7QwcJCWPyfsznuq4y8r79M/9jXomKC5FtiBVLXV+jERMgKRW35YmzJLSts
	4/HTuuZ32r6H+IncnUlwrljGlm94Qt7JGkutAaYE0YifmUAxvzu0p5d8KTCarOPX/CGbv7l4VX6
	zlY517q3/ys=
X-Received: by 2002:a05:600c:3b9f:b0:499:4d4d:822a with SMTP id 5b1f17b1804b1-499821d77f5mr28081345e9.17.1786600158455;
        Wed, 12 Aug 2026 22:49:18 -0700 (PDT)
Received: from smtpclient.apple (ip-88-212-19-42.antik.sk. [88.212.19.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm3437040f8f.11.2026.08.12.22.49.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2026 22:49:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net 2/2] net: skbuff: don't skb_tx_error() the source skb in
 skb_zerocopy()
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <C35992B1-7740-4886-94FF-F85DE8B0106F@doyensec.com>
Date: Thu, 13 Aug 2026 07:49:06 +0200
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
 Zoltan Kiss <zoltan.kiss@citrix.com>,
 dev@openvswitch.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <187134BD-0DC1-4548-AA87-526A45213FEF@doyensec.com>
References: <8063260C-05C9-4997-B9B6-2135063C4858@doyensec.com>
 <C35992B1-7740-4886-94FF-F85DE8B0106F@doyensec.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

skb_zerocopy() copies frags from @from into @to. On an
skb_orphan_frags() failure it calls skb_tx_error(@from), a destructive
operation on the source skb the copy helper does not own. That completes
@from's zerocopy uarg and clears SKBFL_ALL_ZEROCOPY, including the
SKBFL_SHARED_FRAG page-ownership marker.

Both callers already report the failure on their own drop path.
nfnetlink_queue does it at nla_put_failure, and open vSwitch does it in
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

