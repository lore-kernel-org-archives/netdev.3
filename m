Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695875;
	b=i1q+g9uuIo974Hj5+fIFAl39pxYxKK9lfvris/cKF7mfhthPx7TQfyLCchOt77YMNSHC
	 R1WcqTabHJUQquhNEhyQFGfMtrslU84jdOzgfbCo4GpNGNjZHm6YoLHBOtH0doELYjjgb
	 F1xHySv1+UgHGhPVytKr2bbCJs1OupsL+qq3HfIgGgc7x1DNwVoh8+9iNnmTsD66ioMrE
	 QSBBWiTd8Ak+OBV57dc0iPDQm5SIzoj1JHThfm5bWiJB7DTIUAxC3ZDst5Hprv4nqOBEh
	 lrJavAJ0A30JHtYuMJGSejP20aYByk1sRh8OO/rmQRTmPFCYAnnJmQ4s+Bt5QskEJuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695875;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=VO2bFv1GCNjpThVBF9gjl0Uq4uR+QEBbmD1npZ75Vg0=;
	b=q8hJCWQrbZ2yUSoGWLwyu8b6CXVdW29NrWDOjMww+d/lR4LQrmWKS9YmGKTYc5Rc0T1Z
	 0+hE2hsmodhEEa6Gj8cBY/ssELwD0nnilwDb338hrRCO/LNxNNIyxcDPwbyF0r1iC6x/D
	 R3rCxB0ihW67l75qiLT+dwm1+4R/Bs0BClazoysszNIQ3ljph/fOBeuSiia/5YPDcfx5U
	 ajutUTcepKzTcu9VbrtoQvOpZltMdZ8U3lNP9J9s01rn86Ofs9kkXwBByw/oDuZSxP+b2
	 Vf1ZaCk3Stju+cmm+07/oXFwshubDaq2hS0rUBPFiHgupazYR/tzz1VAwogkR840TmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=s6NH3TWq;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91011606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91011606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=s6NH3TWq
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9652820518;
	Tue,  3 Nov 2026 09:51:11 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IhYU7fZPxIQ8; Tue,  3 Nov 2026 09:51:10 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4460520520;
	Tue,  3 Nov 2026 09:51:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4460520520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793695870;
	bh=VO2bFv1GCNjpThVBF9gjl0Uq4uR+QEBbmD1npZ75Vg0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=s6NH3TWqrSsglkkSHS1WN0oWzK8F8I5FTdFNWQiR4Zvfc0b6xnhXUjrOhFtl5lPk7
	 SJCABAwUkcFtV1g/1+A0/NMPCCF3goZJvfQChpWLyL940c5wYr/0fcLNGQFLhqcwbi
	 EwtC0EUx0+v2W/t2xpqwW2BJj5HsDl26T06AGQMShmsWGPbhOra9qfM/m8dQQ+bth7
	 lWvObzruUC8pysME6ajoPWVosZ1TN7zKT6G+zNlXxRws3pdZTnOg+mvbt1v4gvUgZL
	 wJxap7+CHTRjohLlpMYbjdR4LTGE1LEMCoZNZecr6W0BThUsWelsI0tqDYntEB54xH
	 XHuwyTbd1+EiA==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 3 Nov
 2026 09:51:09 +0100
Received: (nullmailer pid 3688640 invoked by uid 1000);
	Tue, 03 Nov 2026 10:51:28 -0000
Date: Tue, 3 Nov 2026 10:51:28 +0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Eric Dumazet <edumazet@kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>,
	<syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] xfrm: iptfs: fix skb leak on error in
 __input_process_payload()
Message-ID: <aum8sFQdO_kGUWxX@gauss4>
References: <20261030083358.2653599-1-edumazet@kernel.org>
 <a555f856-0e74-4579-b35f-9e9c3ed5e8eb@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a555f856-0e74-4579-b35f-9e9c3ed5e8eb@redhat.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Nov 03, 2026 at 09:45:28AM +0100, Paolo Abeni wrote:
> On 10/30/26 09:33, Eric Dumazet wrote:
> > syzbot reported a memory leak of the received skb (and its sec_path
> > extension) in the IP-TFS receive path.
> > 
> > __input_process_payload() parses the inner packets of an IP-TFS payload
> > and queues them on @sublist, which is only sent after the parsing loop.
> > Three error paths inside the loop (skb_copy_seq_read() failure, invalid
> > inner IPv4 header length, unknown IP version) jump to the "done" label,
> > which is placed after the code sending @sublist.
> > 
> > Any skb already queued on @sublist is then neither delivered nor freed.
> > This includes skbs added by iptfs_reassem_cont() before the call, newly
> > allocated inner packets, and, since the received skb can be reused for
> > the first inner packet, the received skb itself.
> > 
> > Move the "done" label before the trim/send code, so that inner packets
> > parsed before the error are delivered as on the normal exit path. The
> > received skb is then still freed (or consumed) as before when it was
> > not reused.
> > 
> > Fixes: 6c82d2433671 ("xfrm: iptfs: add basic receive packet (tunnel egress) handling")
> > Reported-by: syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6ae4102e.9c6421ad.36baac.0005.GAE@google.com/
> > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> > ---
> > Cc: Steffen Klassert <steffen.klassert@secunet.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> 
> @Steffen, do you prefer to take this one via your tree? Otherwise, would you mind
> acking it?

I have a pending pull request for the ipsec tree, my plan
was to apply it once the PR is merged. But since the
ipsec tree is empty after the PR is merge, I could
also ack it if you prefer that.

Steffen
