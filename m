Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268567;
	b=MgsUx9SEtjrc0UN6ifsDEUsBEVzF5vISxrfd9bO2ROINexaVDCUnkFQ32HFPKuI4j2uS
	 1uZ07tJ2VTT0HZ9xSXXrM+p2iGSc/EuI2NVbq4jO3iEKn/a7clj0UqTaTdoRiStY84IeG
	 OLBV4EFynsC0eD6IUx/AY0Kdcs4vE0kxwAnwakqubQfa/sCoJZiSZgJugSd471RER961s
	 BCbvExixoBYuOmhK5I3MvgJL2zZe5sNYUF3Ux2cQk0mN3K1fCyPXUn0ShQgQ2vv1zuJJ4
	 JYI6tm4NNJpdqgszxEQkDbqSsKIlcOITjnDkKQr3LtNHXb3q8NmUDOT3j/vnCNwpbZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=nlqOFSAQ9H7dnLsW36/WDhDu5EY2v33GDHCwxLLecp0=;
	b=b6fyQpw7zYGCGXDP7CStmzVnoYvq9DVYGsums8QFb61p1P1qp32QcfoWx8C8kZOA3W0J
	 Wagb701vabmEeGmcxA+U7B93i/1nVe4zYYtSgdG+TCk/ApjQ9vGRAxbTe1lRiwfV5N/07
	 qsV0kCqxUbWpm47Yu4oBrpY2JBBmRR7NWQ6tiTNURU4yR9BgQeU9bO5sGmzvWDHbxCTWs
	 pyjFV7jOBdGI0YIksw35sy5/ApwCSngadCQcrNyl4JnStUL40foEleAWsiftqi17cHROu
	 YlXPfiunE2Vv+YWzbf51nLsytlyhGNhHHdlO+0Ayc+KjrhOhfBLgvSbYle+fWNl5Wrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b="X71+CO/U";
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FE606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B95FE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=X71+CO/U
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91eed03da8bso8745636d6.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794268566; x=1794873366; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nlqOFSAQ9H7dnLsW36/WDhDu5EY2v33GDHCwxLLecp0=;
        b=X71+CO/UAe8HAQkMdGHqP0bP6m6tjZ6XRSvDGuH1my8Ndb0JVf4fQ2URnECDJrvpfA
         reKuJ2eBA/ZA2j7txXFsYAdmaRpa6qkNvDNPxaLog7FCBEDlTaKbSnQ9UVGdO5JOfnyc
         /dHaEM73uSGSetbd1gS5r7XZ2u/f9Le+jynSfHCCXbp2cqabapOEpkqV/c3bbvevlgAo
         ePjYjVDuPAEaWKuxgVhrlYAptLVu2F5XEXgUw3CmOoJzKQ8oEtB92JEcN+VDfO85PwZc
         uJYKEDM8M5o2cGcIGKTD5o/lbtSWk+JWgklHsllKWcTPCfiBY5B3FGCYZqQojx0u1b/s
         hF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268566; x=1794873366;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nlqOFSAQ9H7dnLsW36/WDhDu5EY2v33GDHCwxLLecp0=;
        b=10ajsNd8vu4YYKRvxysmABrtQbnn37z9xdJRmvjwJ/IhuvM7U2PTYq9TDlWGGfwMHb
         16gU84NMrDxv9A6PsasOJRSZQzlz+0L1NBg/ra6Xpfq7vz3H9XJCjqkwUmMRI7R1/W8f
         35ymSSGQZr2C05QTb05qJxfZsxUXK4uObvu3T1DXcsauHgRpnE0iMFMI29Ar1JDcgOJs
         mr09RzZ/e5EvUyZGxf9oXFo1USdL1EsYIS+1jgm29tgXSHNGlRmHs518kAk4LoAu+B76
         3SvAwFD2y8UK8T8T/pKi//8fQxYrECXRx18kyQLTHfkb3KRJ0wrXlO7QoG0oxo3gsc6Z
         S6wQ==
X-Forwarded-Encrypted: i=1; AL+hErGzvyuMkX+Lh7J0hI4Q/DHYnc5NsdfiAFtoht8/Y81PB18qrqqNS72g8pi2FKsezo3Itu4O2jU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9C/YRfzWIOWXIZ8KiUdwddQPIgqlYRh9k0RrPJ/76Vg05Ej1la
	4ao3S9Rzfu4qWmRbrQXdJM4OBlsSsXdhQJex1iqD5T7zIM6FZWZQycL8bZ4y2sCz3A==
X-Gm-Gg: AYBFou1ksX3bFJtVDTSM/ZdrsySIsULVXAr11mrow0CgHUweOrmcCpMM+CJHwyhfJzl
	tGZhvMImpGPciei/UtqCRlOSljGDMwsHPaJNesZ3j+zWWn2Bh4VUIQDxSj37RWG3Rg/HcpvDliq
	xQ3Hh2qDJhN0kWTn0NBYmKfw0Mee5merIJ0b+ojQwf4y8dv4027osOjN8DTgJJ41UVJBR5u0npm
	lP4gC9OALh0tpNt3Gvuh6EAsTbtEf85/8PAgJZDBIL17L9zzRG86ToUfGxaJZEAk594hD98Mi4S
	8CkxFvHcHP3xBmOrMerp8LFjQGKesU8igs60eRrn/ntnCPPVC0QvUYBv1e2M2EJjgJlN+epUIXh
	12GIV+UYAD7k5ZXi81OfIFSp/4TklOcMhvqiyV82LlqVMqoJ548NT5+/4XpOvfU0Pjr5fjijUp+
	9JmqPVCCdHtwZqWeEmRgSlyIc+TqOMM4ds2W83Pnr7+pSl98dTGLWocF48hhLaZC/iDnbYmOVn/
	5f4G8qqmTRziPOdjkgB+bV3UD0cCpQrQUHCu7IkQszo2ivpTgsHlAbDUCORkgZ1yqWK4couu+U2
	1nqiFY96Yfv5dSwbvAWmpb785nHKZpIeowOUSuYLdcae/X7K8QXlmoJQ8ltgxzJyM+ZntrltBZW
	5e4/wsnzJbKQMZlpRZ68SAMhKgxKKpOQ=
X-Received: by 2002:a05:6214:54c8:b0:91b:5d39:e13c with SMTP id 6a1803df08f44-91eef8650e9mr21004816d6.49.1794268565495;
        Mon, 09 Nov 2026 15:56:05 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04ae351sm7869386d6.12.2026.11.09.15.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:56:04 -0800 (PST)
Date: Mon, 09 Nov 2026 18:56:04 -0500
Message-ID: <a8542108f56e8cac5c6e65977ee01ffd@paul-moore.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261109_1829/pstg-lib:20261109_1442/pstg-pwork:20261109_1829
From: Paul Moore <paul@paul-moore.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnacek@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: don't label bridged packets in  selinux_ip_forward()
References: <179216146138.25460.7866279004288174372@gmail.com>
In-Reply-To: <179216146138.25460.7866279004288174372@gmail.com>

On Oct 16, 2026 Joas Antonio dos Santos <joasantonio108@gmail.com> wrote:
> 
> With br_netfilter and bridge-nf-call-ip{,6}tables enabled, bridged IP
> packets go through the NF_INET_FORWARD hook, where selinux_ip_forward()
> calls selinux_netlbl_skbuff_setsid() and NetLabel may add or remove a
> CIPSO or CALIPSO option.  cipso_v4_skbuff_setattr(),
> calipso_skbuff_setattr() and calipso_skbuff_delattr() move the IP
> header and reset the network header, but the Ethernet header stays
> where it was; when the bridge pushes it back in front of the packet it
> picks up stale bytes and the frame goes out with a garbage destination
> MAC and EtherType.
> 
> Labeling a bridged packet based on its IP addresses is not what we want
> here anyway, so leave bridged packets alone.  Add a stub of
> nf_bridge_info_exists() for CONFIG_BRIDGE_NETFILTER=n.
> 
> Tested with QEMU, two veths enslaved to a bridge with br_netfilter in
> the middle, SELinux and a NetLabel DOI 16 configuration, 5 UDP packets
> per case:
> 
>   case                                        before        after
>   CALIPSO packet, unlabeled destination       MAC garbage   5/5
>   unlabeled IPv6, CALIPSO destination         MAC garbage   5/5
>   unlabeled IPv4, CIPSO destination           MAC garbage   5/5
> 
> Routed packets are still labeled (an unlabeled packet forwarded towards
> a CALIPSO destination gets the option, 5/5).
> 
> Fixes: 948bf85c1bc9 ("netlabel: Add functionality to set the security attributes of a packet")
> Link: https://lore.kernel.org/netdev/CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_6EhAuu4qfUFe_mw@mail.gmail.com/
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Claude:claude-opus-5-5
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  include/linux/netfilter_bridge.h |  5 +++++
>  security/selinux/hooks.c         | 13 ++++++++-----
>  2 files changed, 13 insertions(+), 5 deletions(-)

This looks good to me, thanks for all the work you put into this!  It's
been several weeks with no objections from the netdev folks about the
nf_bridge_info_exists() dummy function so I'm going to assume they are
okay with that; if that's not the case, please speak up soon :)

Merged into selinux/dev.

--
paul-moore.com
