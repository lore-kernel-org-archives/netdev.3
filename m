Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B73B3BF0
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 04:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519910; cv=none; b=VvKSKcWUqFMAMyLtkJ/IIHr8i/IcYFAVgOujLnWg4rfnyehgPlOR+6CzQj7k7rJDh9VaYON+BNcbc++QuNP4Gds4nAQIxtz94RQ7ewhlfVnM5JX8Iq4J7N0ZyS1lhQIBf6PFscnWNL3bNYl6Hcy3Ui+gtdZEfqZqzPph2lhOiIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519910; c=relaxed/simple;
	bh=ZN0/3j0YsAj0Y8viv8Jles0O5wSCfHZM6LwrlcKzO74=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqDlwLLJNpnDyfQ9V8N00wQH7iYv9A64KXledSaKxX7/wBFN+sZ/Sok4zgkKDcjR8E02ljh4g4X5F8NRwXQr935Rs0I2YepLSB6XU6zlR2u6b/uKCuuSKmYH6qWz8OKXVOgvniX+Elhdezd7/0fn55zgZV7aB2Ln6WhtQPV8k3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=n0y//80q; arc=none smtp.client-ip=109.224.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="n0y//80q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1791519894; x=1791779094;
	bh=ZFzpCVRKrDbZKNOmVJlrvnCmDPVToCRnaBbdKV8U/Z8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=n0y//80qaXKwtDFXOVYj17xAW5codTjiWEW14vXhufShPwnViWSR47ryGsitGQ7C5
	 60Vv3k9vFpUgb9laCjthdl7WFc5992TQIl10GH4E6T3TS4c6rYVzeI5aoQGp7ZC0Hd
	 tgZI5Zcl/2uX4zrZxtJ78g0AYKoGF/SyKEcH8QV44gsJ0g2IdA4GXSKTJ05MQohzPH
	 Nlaq5pSTWvcYfKKXB1K49G2gwNSNd1d0bD4hq79hrrlcsLW0+jrRvBXW3L7FvPh6k1
	 MM7k6no+4Jr/XU5z2MdzWnFbVFdXV/dljKOAyIKVVxVxEJqqXfKZ7IFFIxWJx/u8x8
	 zoGi0WQE43bOQ==
Date: Fri, 09 Oct 2026 04:24:50 +0000
To: Joe Damato <joe@dama.to>
From: anmory <anmory@protonmail.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, edumazet@kernel.org
Subject: Re: [RFC net v4 0/4] bnxt_en: Make RING FREE more robust
Message-ID: <jKB4a_PCX3Ixd7mGEqi6YJ9d5K3q0UXAc54Xef0cVVtApXJkDI3W26RxepvlHUqliubo_F6SA2FYQpJ6L5_Yb-ZbDjAXcxBAngIrSdqAQYQ=@protonmail.com>
In-Reply-To: <asV4D3J7K8FzQO4I@devvm20253.cco0.facebook.com>
References: <VyyrJwrwBZEIGezDRJP8QPxbcsGROaxnmohLCnzNQY6sX5CEt0BK3AEC_0MGBx6OxGf4H5UG_xQcqgtAonwmXLdZ5Bd3INWMsof8Oj6ruqg=@protonmail.com> <asVYjdbZGMAEck2t@devvm20253.cco0.facebook.com> <eXJey19uF3K9zJxeuqly_VAGq8y6AiyexdzLKxv22b7m1Av025Dp-w9cGWDelfFwBqcD-wtUIjtz7p1ZYKwlKeyzd3vHHpdY7U6FGPIrK7M=@protonmail.com> <asV4D3J7K8FzQO4I@devvm20253.cco0.facebook.com>
Feedback-ID: 107053670:user:proton
X-Pm-Message-ID: 4ad72c9caab3956c75b0b43ee29396255fb61ed0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Joe, Eric, Michael, Pavan,
quick update from my testing.
I backported Eric's patch bnxt_en: fix DMA mapping length for padded small =
packets onto the exact Debian 6.12.111-1 source and built a Debian test ker=
nel from it.
The affected host has now been running the patched kernel under the same no=
rmal workload and network configuration that reproduced the problem with st=
ock 6.12.111-1.
The relevant setup is:
Broadcom BCM57504 / bnxt_en
affected interface is an 802.1Q trunk with multiple VLAN subinterfaces
Keepalived VRRP with use_vmac
forwarding/conntrack/SNAT traffic through the host
25 Gbit/s link
So far the patched kernel has been stable. It ran for the entire day yester=
day and is still running without reproducing the failure.
With stock 6.12.111-1 we had repeatedly seen the following sequence:
AMD-Vi IO_PAGE_FAULT
NETDEV WATCHDOG / TX timeout
hwrm_ring_free / hwrm_ring_alloc failures
bnxt_init_nic failure
On the patched kernel, the capture has so far only recorded the normal bnxt=
_en initialization and link-up messages. No IOMMU fault, TX timeout, or HWR=
M recovery failure has occurred.
For comparison:
6.12.107-1                     stable
6.12.111-1 stock               reproduces the issue
6.12.111-1 + Eric's patch      stable so far
On this particular host, stock 6.12.111-1 reproduced once after roughly 20 =
minutes, although we have also seen occurrences take several hours. Given t=
hat the patched kernel has now survived the full day yesterday under normal=
 traffic, this is looking increasingly consistent with Eric's DMA padding f=
ix addressing the issue.
I will keep the patched kernel running and continue monitoring it. If the p=
roblem does reproduce, I also have the kernel capture running and will coll=
ect the NIC coredump as requested.
Thanks, R.



-------- Original Message --------
On Wednesday, 10/07/26 at 00:37 Joe Damato <joe@dama.to> wrote:
On Tue, Oct 06, 2026 at 10:22:51PM +0000, anmory wrote:
>
> Hi Joe,
> one important detail I omitted from my previous mail: the affected eth1 i=
nterface is an 802.1Q trunk with multiple VLAN subinterfaces.
> We also use Keepalived VRRP with use_vmac, so virtual MAC interfaces are =
layered on the VLAN interfaces. Traffic is routed/forwarded through the hos=
t and uses conntrack/SNAT before leaving through another physical interface=
.
> We are not deliberately toggling VLAN offload during the test. The reprod=
uction so far is simply to boot Debian 6.12.111-1 with this normal network =
configuration and workload. On one host it reproduced after about 20 minute=
s; on another it reproduced almost immediately. We have also seen a previou=
s occurrence after several hours, so we do not yet have a deterministic pac=
ket-level trigger.
> Given the VLAN configuration, Eric's patch looks especially relevant. I'l=
l test 6.12.111 with that patch first as you suggested and report whether t=
he failure still reproduces.

Seems likely you are hitting the bug Eric just fixed, IMHO. If his patch
resolves your issue, please let me know.

