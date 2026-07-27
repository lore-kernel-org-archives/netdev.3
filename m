Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBCC38B7D1
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153811; cv=none; b=rW8VzC4dzL4a8qEqERrSA0qTm7BBDDLSc4+1zlyP3s0ecol9VMpIUEGTz2lCfuEjpF3YRm9p7BNgkU//XQESbXmcB8jgMDI9Zt/rr9ChjC2bIYqyvFfnRDsYwjaiaEMQB+K24y8d903reyeUT2yDCMBMqTiCKbwvXxJ01AakaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153811; c=relaxed/simple;
	bh=eVQSzY6W4hzKHbJAwtf7ZBUkF0RbWoin5giImFH+LQo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfHz3/L89PM3V1E9/GfmKumMQBoiQ0HWlHrK5Ffiako8cjw2rlo4J3Aix5yxjWtQMaQrg9/tnw3NiTJQfTzjdnNPyyVW7m0S8daht0+we7J2ORQZr6THjrgFb+G5SPtes6J1Cr7Xx7OebZWcPtnNkDliarVJ77qmOatZuVtLZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=m6H6qZBl; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="m6H6qZBl"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A4E7B207BE;
	Mon, 27 Jul 2026 14:03:25 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OhOeXcYDgoLm; Mon, 27 Jul 2026 14:03:24 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A68CD2067F;
	Mon, 27 Jul 2026 14:03:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A68CD2067F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785153804;
	bh=f+4tBaug6b7lgss1dgWwM9r9tcsOVkg6HozryxljGvo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=m6H6qZBlpAjg7HWUx/fybN1oU6e/UYgDcbBRxUDbDk5J1YUzvAM3WwD03iZ6Y4n7Y
	 KlsfM1KhQU9SEYlwu+BuIazBZ+9wbyhnHJX89qZT6QUFx85g0mQ58GIASNWoHpK/sL
	 Fqa2fGzYdqBFaACcrtlfdtP+pkdtmDvY+fHYfK58jes5EBtMhn+wBMGHRXDdcqO/ct
	 A2S15i/I92hKeI2K1SMKrPv2BcbZpwVcmuMe9hCIaFNfdJJs8jBbG+/UhhX5tPbZ89
	 Kw83oWYzqawMdQztSWVvtq84JuMyFMluSueTCRulRkKRG7rUP7u57FBWqY/30w9WV+
	 iw0MOE83OD4fQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 27 Jul
 2026 14:03:23 +0200
Received: (nullmailer pid 4011136 invoked by uid 1000);
	Mon, 27 Jul 2026 12:03:22 -0000
Date: Mon, 27 Jul 2026 14:03:22 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
CC: <devel@lists.linux-ipsec.org>, <netdev@vger.kernel.org>,
	<tobias@strongswan.org>, <eyal.birger@gmail.com>, <antony@phenome.org>
Subject: Re: [PATCH net-next,v3] xfrm: allow to enable udp encapsulation
 without userspace socket
Message-ID: <amdJCg3QqOrO_4Bx@secunet.com>
References: <20260717110118.251866-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717110118.251866-1-pablo@netfilter.org>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Fri, Jul 17, 2026 at 01:01:17PM +0200, Pablo Neira Ayuso wrote:
> It is currently not possible to enable UDP encapsulation in xfrm without
> a userspace process that listens on the specified UDP listener port in
> the SA.
> 
> People have work around this by creating dummy userspace daemons such as
> the one in the smallish perl program (see the script at the bottom of
> this link):
> 
> http://techblog.newsnow.co.uk/2011/11/simple-udp-esp-encapsulation-nat-t-for.html
> 
> This patch adds XFRM_SA_XFLAG_UDP_ENCAP_SOCK to create the UDP socket
> from the kernel.
> 
> Use a hole in net->xfrm to place the new encap_socket list.
> 
> The following example shows how to enable the standalone UDP
> encapsulation:
> 
>     ip xfrm state add src 192.168.10.10 dst 192.168.10.11 proto esp spi 1 \
>             encap espinudp 9999 9999 0.0.0.0 \
>             if_id 0x1 reqid 1 replay-window 0 mode tunnel aead 'rfc4106(gcm(aes))' \
>             0x1111111111111111111111111111111111111111 96 \
>             sel src 10.141.10.0/24 dst 10.141.11.0/24 dir out
> 
> and the receiving side uses 'extra-flag udp-encap-sock':
> 
>     ip xfrm state add src 192.168.10.11 dst 192.168.10.10 proto esp spi 2 \
>             encap espinudp 9999 0 0.0.0.0 extra-flag udp-encap-sock \
>             if_id 0x1 reqid 2 replay-window 10 mode tunnel aead 'rfc4106(gcm(aes))' \
>             0x2222222222222222222222222222222222222222 96 dir in
> 
> This allows for multiple SAs using the same listener udp port.
> 
> This is useful for testing scenarios where UDP encapsulation is
> required.
> 
> Note this patch exports xfrm6_udp_encap_rcv() just like
> xfrm4_udp_encap_rcv() otherwise linker complains due to unreachable
> symbol.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Sashiko found some issues that look valid, can you please check this:

https://patchwork.kernel.org/project/netdevbpf/patch/20260717110118.251866-1-pablo@netfilter.org/

Thanks!

