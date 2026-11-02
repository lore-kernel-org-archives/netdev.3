Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623052;
	b=kqGjmLizEdYVWxpoyCRiWP/0j/4dMihYuHto1wAbsATCNQCQBrNCEDlJOXsFJX99K94z
	 51yzYvk/83u7ybRgx71oNE34kEmv0D2/GFAr5b1HV7CXENolNKV7fiP/HiLAA9dKMsYrV
	 hkAf85UWtJg2v+JfA7hZGeEHBsC3aF+oCWJ/ecHPbe+BmgC32gslY6IQnLJpatOi8oSBN
	 oy2ppmkyjuJEFXunNwpyRWb4Vqkxubhvh4J2QAbTjJWb8+2VrID1waMXooAAZM6BluJma
	 HddH4yC3yYv4LGsRfs1xyo3stRsdS/gEWeJeIZsTpI301rKDpDCvcxR6H+FH0t/tQrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623052;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gccdM5SBnItmENUj+sFwUbujK/STGRaKcAgii696SPA=;
	b=0c4eTB6NCyL2LI44Vr3M+EtbMDjow6NNI9pYtYaWBmH4xN1wPP9/7oOlLGLlSKBp9Jqa
	 /jlsf6a9tCVKTjPFIMpYTxAqu5zF9ON49G62XkvWOIEOecwHpC+UgpcIExUXb28K9lVfs
	 CXF1WubBL0PtNniL3cdT6NCn9T18kAtdTHwufFWvI2A5lGAQ6NyNCsE4sbyP9gGIXBbrx
	 k0ii+fFDIEU0mF47X6nIccn95ctvq7Du7rTdEBq7YtOW/m/XYeFRqx4XyPTAeF6mplvlH
	 c4eTc4HGXPbg9TAT8+eusd72lxmAojnUYh3GYJG2hyxwCcButNUJyGW2AvP901efXdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XaY6mEUI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4BA606A329;
	Mon,  2 Nov 2026 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XaY6mEUI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2FA1F00A16;
	Mon,  2 Nov 2026 12:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623052;
	bh=gccdM5SBnItmENUj+sFwUbujK/STGRaKcAgii696SPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XaY6mEUI2EnsGplIHGQHYLYYSyovQZcWYsvh25JSMtIAwk7jMiMVn+ns8JI2KkRjE
	 yAfY99ATBWhu96/o2OAs5F6t1XA9UHUP9GfXf02AKOUoNy/z3enc0zHwijTPJO1SEU
	 vSceFqceyBRGhS+bU271Yi0jHcmIVJDcxxOltgMviyy4MG5UseJjvPzoYMncGblNAr
	 RWVOtauquYjLeSmAaMOsmmmg4M24mG5vLwuMkHliEuJHgkXI4Pot6+LsTENYW4p0y5
	 RtCLxV20iZTbuNCTf3YmwUVWQhMWH3gmDlujzR+RnGcQzAztldQQLnh0WF23s8sFbo
	 rj+dtWM6/ctvw==
Date: Mon, 2 Nov 2026 12:37:27 +0000
From: Simon Horman <horms@kernel.org>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: Avi Weiss <thnkslprpt@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Hurley <john.hurley@netronome.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
	yana06070@163.com
Subject: Re: [PATCH net] net: skbuff: reject zero MPLS TTL before decrementing
Message-ID: <20261102123727.GE257209@horms.kernel.org>
References: <20261031114135.3784868-2-thnkslprpt@gmail.com>
 <179345092130.132560.5590780813492711780@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179345092130.132560.5590780813492711780@cmss.chinamobile.com>

On Sat, Oct 31, 2026 at 08:48:41PM +0800, Xia Yan wrote:
> On 10/31/26 11:41, Avi Weiss wrote:
> > skb_mpls_dec_ttl() decrements the u8 TTL before checking whether it
> > expired. An incoming TTL of zero wraps to 255, causing the TC MPLS
> > dec_ttl action to pass an expired packet instead of dropping it.
> >
> > Reject a zero TTL before the decrement while preserving the existing
> > behavior for TTL one and valid TTL values.
> 
> Nice catch. I checked the wraparound against the C promotion and
> conversion rules: with ttl being a u8, a zero TTL on the old path
> decrements to 255 and the packet passes with a revived TTL. The new
> check catches exactly that case, TTL one still returns -EINVAL, and
> values of two and above are unchanged bit for bit.
> 
> The only in-tree caller I see is the TC dec_ttl action in
> tcf_mpls_act(), which maps the error to TC_ACT_SHOT, so the rejected
> packet is dropped. mpls_forward() already rejects TTL zero and one
> (`dec.ttl <= 1`), so the two MPLS decrement paths now agree.
> 
> One minor observation, no change requested: `!ttl || !--ttl` is
> equivalent to `ttl <= 1`, the form mpls_forward() uses. Stylistic
> only; the patch is correct as posted.

Let's not get bogged down on this one. But FWIIW I think the decrement
is needed for the happy-path to work correctly. In particular, this line
which appears after the condition under discussion:

	lse |= ttl << MPLS_LS_TTL_SHIFT;

> 
> Reviewed-by: Xia Yan <yanxia@cmss.chinamobile.com>

Reviewed-by: Simon Horman <horms@kernel.org>

