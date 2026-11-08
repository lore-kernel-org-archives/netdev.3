Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794109719;
	b=hPxQMwrYLJAdb5HjW/xI8IlaqnsMKqikAuTD3J1ABr/Rjx7KwYKPpKCe1VRsPrd7rvRF
	 dACra5JX4LsDSInHfDK2LuNq+Dyg4wHMlP2wB+jsXcxtqnivybgN+i4ZxQ5inxqdUG8B+
	 maa/xDFM28d7QczgfJCQosZIk2Yy8wEBBtIzgzqpT+Nvomr5tsKsgY50I2NKCYEXSjLkH
	 +YpWLe5SgG8SYfPwc6Rm0iefPtMDH508QSwQUrfyXN9PDeOYeeBQLotFTGgelFrE6gKcp
	 oPsCc+WxIiwoT/BJ95WRTG2/oGw537PKBj3uSo7POY1idmiEfwhoUB1TLqfBUR/Go2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794109719;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TZiwCM2N46vTpQtDwGQiax0bnFKCo40uZq0Xn4XOGzQ=;
	b=YCHcV2pKBR8zQeviGoqBfg6SH8dzSBGYyH76qXdOlCiZs4J7bAo5bakp8k7dKetVJUWu
	 ltPH4hzf614MyqDwsxPBwWhU++ZOSixZmoVzH3H/W2qS1sVghdCD6vvlM0gvfqlhUJzhi
	 J+Z4lfl54K5edEX4cSnhIINFPczWO5m8NaT72hrU0/Fppyn10rHX04fV2B6Nr4+3Xoogf
	 VbZjAuEn/MnnQRW/3KJnz/JwVD8+7637nNVWh10Kqo+fyf5z7dZeDQu0DriETfzws3g+f
	 OSKg+DxbdIXptHnGaJVO4zyGSf+xApkNRD8L5Ma8o9njMu+K6+DV47IhWlrErTZ5o9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWpQQY3F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78E606A31F;
	Sun,  8 Nov 2026 03:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWpQQY3F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEDF1F008A1;
	Sun,  8 Nov 2026 03:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794109718;
	bh=TZiwCM2N46vTpQtDwGQiax0bnFKCo40uZq0Xn4XOGzQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TWpQQY3F3XHqMfmPt/mhf+VxDNGrw/P3UN54DWGxyqflxQsaQtr7obQOL+jomh2Vu
	 8T6PPgNIpnNqy+I/Ktxwpb2q0pVQZ0LAkwtiBBh5KyVHFmvmVlV2J7KlCNn7cIUSgY
	 6F8cjhnYqaGlqup6ZN8HtttH6P1EsTQSNN3dRSPCrXUR1pLIP6astsexhVDiKQ0YKC
	 N4EWPEBvp451XOIcgWqdhq4LHOLAnnxA0qgzmCc1q5030y93l/DpMn8pPWGxF7FpLj
	 iwpNcdMxuQvOXgSg7iRpRkc0v7InjZ3xEBwMnuc3s5/vM6TejZopJZ7tkV9UV90Jw4
	 00gdBB5CajTUQ==
Subject: Re: [PATCH net v8 3/3] xfrm: hold the tunnel device reference across
 the input path
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 03:48:37 +0000
Message-ID: <179410971777.994134.15451365974741782333@kernel.org>
In-Reply-To: <20261107111617.21347-4-q.h.hack.winter@gmail.com>
References: <20261107111617.21347-4-q.h.hack.winter@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch adds a reference that leaks, and the leak fires a
  WARN on the error path that the async-teardown fix is meant to cover.

--

xfrm: hold the tunnel device reference across the input path

This patch makes vti_input(), vti6_input_proto() and xfrm6_rcv_spi() take
a reference on the tunnel net_device when they cache the tunnel pointer in
the skb control buffer. xfrm_input() releases the reference on delivery
and on drop, and IPTFS releases it through new helpers,
xfrm_input_drop() and xfrm_input_consume().

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index cfd5cea033127..e3b6c486f0e9c 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c

[ ... ]

> @@ -781,9 +838,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  	spin_unlock(&x->lock);
>  drop:
>  	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
> +	tdev = xfrm_input_take_tunnel_dev(skb, family);
> +	kfree_skb(skb);
> +	if (tdev)
> +		dev_put(tdev);

[Severity: High]
Can this leak the tunnel device reference taken by dev_hold() in
vti_input() or vti6_input_proto()?

At the top of xfrm_input(), in the resume/GRO/offload branch, the
invalid-state check jumps to drop before family is assigned:

    if (unlikely(x->km.state != XFRM_STATE_VALID)) {
        ...
        if (encap_type == -1)
            async = 1;
        goto drop;
    }

    family = x->props.family;

At that point family still has its initial value, AF_UNSPEC. The slot is
non-NULL, so xfrm_input_take_tunnel_dev() falls into its default case:

    default:
        WARN_ON_ONCE(1);
        return NULL;

The slot is not cleared and tdev stays NULL. The skb is freed and the
dev_put() is skipped.

One way to reach this is async crypto that completes after the SA has
been deleted or has expired, for example during an IKE rekey:

vti_input()
  dev_hold(tunnel->dev)
  xfrm_input()
    esp_input() returns -EINPROGRESS
<SA deleted, km.state no longer XFRM_STATE_VALID>
xfrm_input_resume()
  xfrm_input(skb, nexthdr, 0, -1)
    goto drop with family == AF_UNSPEC

Two other paths look the same. One is an offload skb that enters through
vti_input() with encap_type 0. The other is the IPTFS outer skb that is
passed to xfrm_input(skb, 0, 0, -2) after the SA has become invalid.

If the reference leaks, a later unregister of the vti/vti6 device or a
netns teardown would wait forever in netdev_wait_allrefs_any(). The
WARN_ON_ONCE() would also panic the machine with panic_on_warn set.

The commit message says:

  "The early drop for a state that is no longer valid releases
  the reference too, and needs the address family for that, so set the
  family before the validity check."

The diff doesn't move the family = x->props.family assignment ahead of
the km.state check, though. Was that hunk left out of the patch?

>  	if (async)
>  		dev_put(dev);
> -	kfree_skb(skb);
>  	return 0;
>  }
>  EXPORT_SYMBOL(xfrm_input);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107111617.21347-1-q.h.hack.winter%40gmail.com
