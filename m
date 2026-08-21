Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BEC4611E1
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304392; cv=none; b=AG+DKbn4sJiQV7n7rrTSdv5DmomTfMUAM6Wb/P6PHHDuqHh37YohAKVxDWLfU6EGdeVGxBiCT8+HG1SRtmTYbull07FT5cG9OTUMhK2HtT+BFAQ/50+IGMxWJE4OxI3FSUyH2/B+VFG+PwZlf94uG8190kMxVSYkhRnVHCyUFIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304392; c=relaxed/simple;
	bh=XLg7rKpGO8Yqvak+1z62LOnFxoHsD2BRglXUoG22Z/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKpgKJ6IZ5NOlgFNHpebwIzLcy0toz7i/GRKm3c6eaqYA8J7Avj6Bvk+ojN1ld/ip1B4MtyEXFEzHSHeIg3nLF/fCOxRrOg69TotLb86Vrw4CkHsdgrxBi8ROyZQcZbaFiG+mm57x66rAadCIFe+KSF6tMO15yIG10CqjLIqZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj1AMAZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj1AMAZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5C81F000E9;
	Fri, 21 Aug 2026 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787304381;
	bh=I30nrGeVO2qSThwkhJivSx17E/vdPy7KXMU/8oZ0upI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sj1AMAZRqGlZVa4zLN7VDewwhJLnCOYiu1RENgLPr6TnDMXMODja+63+nRAqpSdMT
	 TkO6fr5qsKBxGhUp+/03Rfg/pNskL/1Y5qgF34cBDOULxcgDWbucb/oqplO8p+LH9A
	 y91CvQ0i8BBJ9208yeUm8GgMRsre3rQTXpHHkiOJo9pZggZycG/WoiZrh/o42YIG4s
	 V+0i56HmL9CqSm69SGVV6J0KHn7FAYL77DJs3ziwQD1YTWjrSo3G/SWOCbE13XrE1d
	 OLtSCdSMHQCHZhB5TzEaLlcClRIiaiv76c3VWuqdLcuiO6kLNIZiPcaSaOY1btGIIU
	 pqzrHjpzXtepw==
Date: Fri, 21 Aug 2026 10:26:18 +0100
From: Simon Horman <horms@kernel.org>
To: Chuyf26 <Chuyf26@linux.alibaba.com>
Cc: Dmitry Kozlov <xeb@mail.ru>, netdev@vger.kernel.org
Subject: Re: [PATCH] pptp: reject payloads shorter than the PPP protocol field
Message-ID: <20260821092618.GF265046@horms.kernel.org>
References: <20260818162143.gn-j15t2twSq3EK4tluniorb9JMdD9cS6_NWtWioiRc@z>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818162143.gn-j15t2twSq3EK4tluniorb9JMdD9cS6_NWtWioiRc@z>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818162229.yOFI43Vfo0v911uVw0AFpyHQ_aOe_fsjoQXPZP70vMI@z?part=1

Simon says:

Given the first issue raised by the AI-generated review below, it seems to
me that this is more of a hardening patch - for net-next, no Fixes tag -
than a bug fix - for net, with a Fixes tag.

---
--- Patch [1]: [PATCH] x25: validate class D facility length before reading it ---
commit 37de2e4212c8268079bc40f17b99b1685565a4da
Author: Chuyf26 <Chuyf26@linux.alibaba.com>

    x25: validate class D facility length before reading it

The patch adds a len < 2 test to the X25_FAC_CLASS_D case of
x25_parse_facilities() so that the two facility header bytes are known to
be present before p[1] is loaded. Classes A, B and C already validate
their fixed lengths in the same way.

No Link: tags are present in the commit header.

> x25: validate class D facility length before reading it
>
>     The over-read lands one byte past the packet data but inside the skb
>     data allocation, where KASAN does not report it, and the value read
>     then controls how many further bytes the parser believes remain.

[Severity: Medium]
[Finding: main-1-0]
[Sources: opus-5]
Does the value read actually reach the parser's length arithmetic?  In the
only case where p[1] is outside the validated range, len == 1, the
pre-existing check already rejected the frame:

net/x25/x25_facilities.c:x25_parse_facilities() {
	unsigned int len;
	...
	len = skb->data[0];

	if (!pskb_may_pull(skb, 1 + len))
		return -1;

	p = skb->data + 1;
	...
		case X25_FAC_CLASS_D:
			if (len < p[1] + 2)
				return -1;
}

len is unsigned int, p[1] is unsigned char so p[1] + 2 is an int in
[2, 257], and the comparison is done after conversion to unsigned, so
1 < p[1] + 2 holds for every possible byte value.

That means the len -= p[1] + 2; / p += p[1] + 2; statements and the
CALLING_AE/CALLED_AE memcpy() paths were unreachable for len == 1 both
before and after this change, and the new len < 2 clause returns the same
-1 for the same input.

Would it be more accurate to describe this as removing a benign one-byte
read rather than as a parser length bug, given the commit message itself
notes the read stays inside the skb head allocation?  Does the
Fixes: 1da177e4c3f4 tag still make sense if there is no behavioural
change for stable trees to pick up?

> diff --git a/net/x25/x25_facilities.c b/net/x25/x25_facilities.c
> index 6dadb217e101..bfb269538984 100644
> --- a/net/x25/x25_facilities.c
> +++ b/net/x25/x25_facilities.c
> @@ -147,7 +147,7 @@ int x25_parse_facilities(struct sk_buff *skb, struct x25_facilities *facilities,
>  			len -= 4;
>  			break;
>  		case X25_FAC_CLASS_D:
> -			if (len < p[1] + 2)
> +			if (len < 2 || len < p[1] + 2)
>  				return -1;
>  			switch (*p) {
>  			case X25_FAC_CALLING_AE:

[Severity: Medium]
[Finding: main-2-1]
[Sources: opus-5]
This isn't a bug introduced by this patch, but while the class D branch is
being touched: should the facility length byte and the declared semi-octet
count also be checked against each other?

The CALLING_AE and CALLED_AE cases in x25_parse_facilities() validate the
two independently:

			case X25_FAC_CALLED_AE:
				if (p[1] > X25_MAX_DTE_FACIL_LEN || p[1] <= 1)
					return -1;
				if (p[2] > X25_MAX_AE_LEN)
					return -1;
				dte_facs->called_len = p[2];
				memcpy(dte_facs->called_ae, &p[3], p[1] - 1);

There is no test that p[1] - 1 >= (p[2] + 1) / 2, while the emitter
x25_create_facilities() ties them together:

	if (dte_facs->calling_len && (facil_mask & X25_MASK_CALLING_AE)) {
		unsigned int bytecount = (dte_facs->calling_len + 1) >> 1;
		*p++ = X25_FAC_CALLING_AE;
		*p++ = 1 + bytecount;
		*p++ = dte_facs->calling_len;
		memcpy(p, dte_facs->calling_ae, bytecount);

So a peer sending p[1] = 2 with p[2] = 40 makes the kernel store
called_len = 40 while copying only one byte into called_ae.

Two follow-on effects: userspace reading SIOCX25GDTEFACILITIES in
af_x25.c gets a semi-octet count for 39 semi-octets the peer never sent
(the buffers are memset at the top of x25_parse_facilities(), so this is
fabricated zero data rather than a memory disclosure), and on the accept
path x25_rx_call_request() clears only the calling side:

net/x25/af_x25.c:x25_rx_call_request() {
	/* ensure no calling address extension on accept */
	makex25->vc_facil_mask &= ~X25_MASK_CALLING_AE;
}

so the peer-supplied called_len survives into makex25->dte_facilities and
is fed back to x25_create_facilities() when x25_write_internal() builds
X25_CALL_ACCEPTED, emitting up to 20 mostly-zero AE bytes.

There is no memory-safety consequence here: the memcpy() length is bounded
by X25_MAX_DTE_FACIL_LEN - 1 = 20, which matches sizeof(called_ae), and
the worst-case emitted facilities block stays inside X25_MAX_FAC_LEN.

Would it make sense to reject encodings the emitter can never produce, in
the same spirit as the header-length check being added here?
-- 
pw-bot: changes-requested
