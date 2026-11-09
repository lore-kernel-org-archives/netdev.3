Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256029;
	b=FnbAXwbQaLdqYylMr+hXSLyjjy1UEE65qmKSxEE38dxLQtfOlcta7K99wC1H/Fq8uiqH
	 7XxQT96sKN2qrVERK0DmK63pNlQ9rD62s1siRD2I5hOFRojGw9KaAxAUAWCbO7fIpGNV4
	 K8B4YrwLjlp/VBIukoP+o1yFNdSsBuIxoVjQ9LAq2m1ML70TsCJrmtAIQq/TMtY+a6Hhg
	 o85SCDkYu/x7OEmuFUF7tl46LL+WPF62XYSlnuGw+Gg2tQpG0aNyti5CIfAMiw1j0ICVb
	 RR9Fdmn+0ldFmLfaiP4d1vrNVd+KJOHGaHWUR+1jn8PNoySkVMaZuN48a61o6lZXqtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256029;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Outbound-Client-TLS:X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=bcCj37QXBo2faBMQRqYXM+W4gZMvIt0WpAHiYS31Xqc=;
	b=pWjKyQItojCc+Pf5du56LwX/JCuVdUV/oUX5dmY2azyHsAHoQLl6G+ns7+hu0N1NXmO4
	 1qeVE3wg/iBqaZEO6vihvO2dpmwZFBiHbr4U1xCnNf2nbVhxZcD2UXCJDtfRW2w+9TGiR
	 7mc8e39Hg/ctS8ePUbT1mneZtFEg1LAIiTKoqJ/41eimjUDQZ/ss90T1eAtZ1+IeDWJre
	 SdG7A0IrI8jflwVTdNOs9E+PyWbJe8QQVLmH7jJZxl0/5OQkMH2BrEvz8AgiwMg+7eoSN
	 yhpQ0mKegaXXfF7igYJFxrnL/NvzK6g6+HsP9MVSu3bNs7TpkyaaEM6F6fROX+SIQeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=jMpO6DuE;
	arc=none smtp.remote-ip=173.37.86.72
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA768606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 20:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA768606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=jMpO6DuE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1849; q=dns/txt;
  s=iport01; t=1794256028; x=1795465628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bcCj37QXBo2faBMQRqYXM+W4gZMvIt0WpAHiYS31Xqc=;
  b=jMpO6DuE2rVBv+PbMPkWImKGfJq6nQ8TgzhZlHyKXAV7q587YYlNFgSM
   axLjVjnLrgzxaxFh37jnMVbTZG2cdZVR9txjzg7kk59aHSNbPQg60YL2M
   xKRtfE2YkGzBKXSeXLH9e5ZI0fkoDBrgsSryU1Ckn/wV4IvtZp08cn80A
   IN1HU6XuEE+8KHyhgsktjXYr4h4yy42Sf80z2RlTKJaUaXDCd+Ccr2AFE
   54tBr9iy/AIZ+Tzy9yglRdjzJrZXRCgYeuqApr8xFippYxjTzdvfgutFr
   el03lBTjbx4NgpmcZcdk8bqQTN1SH+btBwm1aDjF6uEPkc/OpMB8d8a6w
   A==;
X-CSE-ConnectionGUID: Ob1lbcNTQ+ehrypibLRXhA==
X-CSE-MsgGUID: h4mJSjZgRMmEDEuXOH/Y8A==
X-IPAS-Result: =?us-ascii?q?A0BfAwAHLPJq/4r/Ja1QAQmCWYQsQ4UgkXSeJBSBag8BA?=
 =?us-ascii?q?QEPUQQBAYUFAo4dAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBAgEHB?=
 =?us-ascii?q?YEOE4ZckBMCAQMjDwFGEAsaAiYCAlaDG4J1A7pxeoEygQHeSYF0FYEKLoV0g?=
 =?us-ascii?q?m4BhQN2hH0nG4FJRIEVgys+hBYBCAtmgw+CagSCDRWBDJdPSAp4HANZLAFVE?=
 =?us-ascii?q?w0KCwcFgSVDAzUSKhUjSwUtHYEjIR0XER5YGwYFEiAqQUNbgRKBB12BKyhdA?=
 =?us-ascii?q?QIfRi0VgXYCglGBI10CAUlBDgdFUwklQxJHJCIIEgkBExosCoEaNTwJJj8VD?=
 =?us-ascii?q?GQIAxoFGiYCHwgCCwIMdCgREBMdHiQvBRwmPhsKSxgNSBEsNxUZBD0BbgeUb?=
 =?us-ascii?q?wFwMDR3ASxNGiYOHww7kwySSIE1ikOVGYQqgWifdhozhASUGZJUmQikDk2Ea?=
 =?us-ascii?q?YFoPIFZMxoIGxWDI1IZD95jJm8BAQcCBw4DC4FokBGBbQEB?=
IronPort-Data: A9a23:0VAWqqxeC7RsfeunwJZ6t+f0xyrEfRIJ4+MujC+fZmUNrF6WrkUCx
 jYdWDrVb62PNGb2eY8kat7l8x4C7JHRz99jTARuqFhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCKa/lHyYuCJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 4yaT/H3Ygf/hWctajNMt8pvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJGY8ZIkS8cBLOCJD9
 eYJMDEHSiqzh8vjldpXSsE07igiBNPgMIVavjRryivUSK5/B5vCWK7No9Rf2V/chOgXQq2YP
 JVfM2cyKk2bM3WjOX9PYH46tPyhmnjkcz5YgFmUvqEwpWPUyWSd1ZCwbIeKJIXTH5o9ckCwp
 j7D3V/7MB4gEdmy5ReYwlWMwd6ftHauMG4VPPjinhJwu3Wfz3IeDTUaXEW2pP2+hFL4Xd9DQ
 2QZ9jcrpLo/6GSoQ8P7Uhn+p2SL1jYfRtBZO+438geAzuzT+QnxLm4JUjJMdpkss9N1XjUx1
 l6KmPvqCCZpvbnTTmiSnp+dqz+oNDdWK2IeaSIaZQ8Y5d+lq4FbpgrGRNtlEYavg9H1EC22y
 DePxAA4iqkfgNAjyaq25xbEjiiqq5yPSRQ6jjg7RUq/5Q9/IYrgbIuy5B2DtLBLLZ2SSR+Ku
 31sd9Wi0d3ixKqlzESlKNjh1pnzjxpZGFUwWWJSIqQ=
IronPort-HdrOrdr: A9a23:spUsu64btt2NLyg5aAPXwO7XdLJyesId70hD6qm+c3Bom6uj5q
 eTdZUgpHvJYVkqNk3I9errBEDEewK+yXcX2/h1AV7BZmjbUQKTRekI0WKh+UyDJ8SUzIFgPM
 lbHpSWcOeRMXFKyeDn/QK/D9EshPOD8KyumKPi6k0Fd3ANV0mlhD0Jcjpy1SZNNXB7OaY=
X-Talos-CUID: 9a23:8p0TTGxbuaL+T7Aa7jPYBgUzEJkheHb78E6TLk+iGH5oQpmveV+5rfY=
X-Talos-MUID: 9a23:7apjxAYjAQF/d+BTt2PppgpgBshSxqGDJG0QobIm/PjUHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,204,1787011200"; 
   d="scan'208";a="545761127"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Nov 2026 20:27:00 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 633B418000285;
	Mon,  9 Nov 2026 20:26:59 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
To: netdev@vger.kernel.org
Cc: netdev-bot+sashiko@kernel.org,
	sebaddel@cisco.com,
	aradhana@cisco.com,
	rfaucett@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v6 0/2] enic: retain admin DMA resources and identify V2 VFs
Date: Mon,  9 Nov 2026 12:26:55 -0800
Message-ID: <20261109202655.4140185-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v6-0-155d64f802e9@cisco.com>
References: <20261107-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v6-0-155d64f802e9@cisco.com>
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
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-01.cisco.com

Thanks for the review.

For patch 1, I am keeping the conservative surprise-removal behavior.
An all-ones MMIO read or PCI disconnect state establishes that the queue
register is no longer readable, but it does not provide the queue-stop
proof used by this patch for previously issued DMA. The driver therefore
releases the admin graph only after directly observing RUNNING == 0. If
surprise removal makes that observation impossible, the graph and PCI
reservation can remain retained until reboot. V7 will state this
limitation more clearly; the code is unchanged.

The reset-worker source comments in V6 already describe both outcomes:
resources are released only after both queues report stopped; otherwise
the channel is quarantined and the reset is abandoned.

The failed internal reopen followed by a repeated datapath stop is a
valid pre-existing lifecycle issue. It is separate from admin DMA
ownership, so I will address it in a separate datapath lifecycle fix
rather than add a partial fix here.

For patch 2, the code implements the deployed identity contract, but the
V6 wording incorrectly described it. Firmware vf_index and mailbox
src_vnic_id use 0xffff for the PF and zero-based values for VFs. Hardware
CQ sender metadata uses 0 for the PF and vf_index + 1 for a VF; receive
handling converts that value to the corresponding mailbox source ID. V7
will correct the cover letter and commit message.

The 0xffff PF mailbox source is intentional and matches the deployed
protocol; V7 will document the change from the previous zero-filled
field. V7 will also document that READ_ONCE() and dma_rmb() order the
common DEVCMD2 result path before device-written result fields are read.

V7 changes public text only. Its code and stable patch IDs are identical
to V6. I will post V7 shortly.

pw-bot: cr
