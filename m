Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762765;
	b=mhu93Lu8T+zlmUlYwrjHxoNs8K5i7aGM0JPhm5C8nx5MEIBCX6yZAv2/UYvmUiGwSqst
	 rk1tHCa/vnR/0g2RY34TDFDlYQ6LhIp97nnlDTjvrI1XVAL8uM/OLEowdlGXyTBFEzegB
	 l028g1TYbPqjLwO9wyleyAsdTzZerlxDM9w/vbSkuelDZpgW5O/UvadFuV+2NevxHZg8t
	 kJIJO3F7W+GEWim36di6KITX2ApsWwnJaA3Pn/cU6qI+U1dnKRQaXoxfKjBq6fr9g10cr
	 PmfB9EmzM4Icaren/oT8SzeEX+bHYX48udZSx4TuLc2jFTOk/kIK7bkBGgPwoVeBLbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762765;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=q/FXb9aWk8RMV4mySgy4meuQjo/Ip780RyKlEE+DHWA=;
	b=NQFzZWs/GG99MFItyMNortRJWE06D2lwK3LOhZ8fcptNSdLCDoixedhhNNijPepwLJIl
	 By/FjznsvpB6J5/jGmqhEa7YwhkbCqNXagFk84TckpK0/mK3ypX9W3FkRsV841FWwRIM3
	 HCV73WAuJBF2GU4aB8fGCyopphFzMaHOxbXN0dFbQbZLL9tXYP4ZM/2dptenoQAMhnC0y
	 /cce2J7bXV7yh3yInkd5dIyAjZCQ2r9nnsSUslmVlhyoeFRQLMQNxO8cPivBgiVBlUNJh
	 ThYWwZY0APdQMTAQifk1YcaUWzx+gYU9V+chFma0pfiEQyorhLcnt1vqNj3dggmodug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39300606A32A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39300606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso144049666b.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 06:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762764; x=1793367564;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q/FXb9aWk8RMV4mySgy4meuQjo/Ip780RyKlEE+DHWA=;
        b=Y6Ir9jceO3WvFnJ1D/1cWGZBVkHXMMsKDv0BaSPLWRT3daAugxKTRgZkkn0FM0B6f3
         O5i0/5ethwv7LyZgcA23z0hUoFEGmVZXgGASIGVE9ldvantE4lDwsRzFfknTsX6pbovk
         UUUS6ICArQ/qoD6a45+OxGazHH1leabVeZx1K1unGswlCmSaOwsHNBz6Itdl0gaVNEtC
         C5e5l+KnRt8Gw+mheH0Yl00XODHALsNPvQXWaJX4E+JgLrOwZTAL7W0mJBInHbeCmL6a
         UnDNl2ezdTrl+yhKdhkxSt8hnw5ep1xASYFF2QyMJ2e1C3JCUHnTvUZNDS98W1cPmaiB
         5NMw==
X-Forwarded-Encrypted: i=1; AKwUvBw0T3Wqj66UrAgrmmrH/YKaaMIHJgdi/G9P5xQ0lcHXEzdT4y3gCzrsPUNPqv8BaeWrlOpKnbA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9IbK8cWxELXYWtpyiX/aKmX0SHFDHt4FM6RGDvPJ19t2PrdCd
	nVy6foBaE44ae4kFkmy7o0d6pJPlcZDB8gDjM0dzpH53F8ugO33Yb72c1XHZvctHkmA=
X-Gm-Gg: AYBFou0FNP5N0/RrzWD7rlLfWiMXS6r8DsrCOMh0otNpiiwIqxRS/Ir9bk3TYpdnhLn
	MMHPpAd/4KTYtdZuU5j1mZlmxdipBK03oSxVeN2jxCVSZ6vp/z00S8GqvixYfYInVMu5MOKWD7B
	s8nxOjRuqGyJBxJzLB7DQQBDyYz9oO7nUqzZ6GkCCnKHKGGQI2qfyuCyZTYIpphirPaP5kF5gE2
	6JAht8+vWavmpdlvbUeoFB9TiRHgmnhUXA2Z+zuRS2UzPdRpjyGqZKdhgId0M8LMu7kL5BywnC0
	qcrykmqx7xCiIzf6MylKGWkUK5gQHwmscILb9hRBlYBgoqSpTs43BWO4hee0vAmS7Cjp45UKBRp
	jelMUUbBtcBJ24D2LvgYHvHwYMMnQBPjfyG+kEuFOZgpWK++vxrzmPIUzC3OBCAu+QZqnPQNa8E
	E2O8WD7P2qH31SgiRRBFPCr80Iv64XzE/SN910a8eD4hdK11vLhOST43f0D+LStEJ2zaRYOhg0W
	x1+3lR3TJBsdnmbMbT71cwBHCKQC32PE+0zptzx2pa1b4rKWMAzKY8XPuNpb0GJo0MkPnwH1ERe
	bBIgb4EU81QHx6P8EA==
X-Received: by 2002:a17:907:3e29:b0:c42:bc58:f26 with SMTP id a640c23a62f3a-c46a93d3068mr340891766b.26.1792762763495;
        Fri, 23 Oct 2026 06:39:23 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46b8bc4c97sm2102366b.46.2026.10.23.06.39.20
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 06:39:22 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so1390987a12.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 06:39:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBymWsb1TV5Ltw/1wiS0UrgCGd6pTC1bXMqMUr5RVsDLxB7p19rjjS3K0D8QJZMn9ryHtpPArq0=@vger.kernel.org
X-Received: by 2002:a05:6402:1f11:b0:6b1:d148:5a0a with SMTP id
 4fb4d7f45d1cf-6b432be9346mr3876276a12.19.1792762760594; Fri, 23 Oct 2026
 06:39:20 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014-dev-mctp-usb-lib-test-v3-0-ee5bc3ea1db1@codeconstruct.com.au>
 <20261014-dev-mctp-usb-lib-test-v3-6-ee5bc3ea1db1@codeconstruct.com.au>
In-Reply-To: <20261014-dev-mctp-usb-lib-test-v3-6-ee5bc3ea1db1@codeconstruct.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Oct 2026 15:39:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXTGGdGWZ9sKz5_sQF1237gV844cEhkXr6v_TUHPOb78Q@mail.gmail.com>
X-Gm-Features: AclHuK_taSWkqoWJ55TGYbrilVkTwq1Avu2z2PyWM4RMVHph7TJaMbjqEHNy60Q
Message-ID: <CAMuHMdXTGGdGWZ9sKz5_sQF1237gV844cEhkXr6v_TUHPOb78Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/7] net: mctp: usblib: Add initial kunit tx tests
To: James Lee <james@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi James,

On Wed, 14 Oct 2026 at 06:54, James Lee <james@codeconstruct.com.au> wrote:
> Add tests for the transmit path, where MCTP packets are handed to
> outgoing USB transfer data. Testing a spanning transfer that is expected
> to succeed, the failure paths when sends fail, and large sequential
> sends.
>
> Signed-off-by: James Lee <james@codeconstruct.com.au>
>
> ---
> v2:
> - Correct flex array reference
> - Simply return when mctp_usblib_test_tx_send() fails
> - Use skb_put_data() instead of manual assignment
> - Remember span parameter exists

Thanks for your patch, which is now commit 1e12f734afc10477 ("net:
mctp: usblib: Add initial kunit tx tests") upstream.

> --- a/drivers/net/mctp/mctp-usblib-test.c
> +++ b/drivers/net/mctp/mctp-usblib-test.c

> +
> +/* Test sending multiple packets in the same transfer, followed by one that
> + * spans multiple subsequent transfers.
> + */
> +static void mctp_usblib_test_tx_multi_push(struct kunit *test)
> +{
> +       struct mctp_usblib_test_ctx *ctx;
> +       size_t i, max_length, tx_length;
> +       struct mctp_usblib_tx_ops ops;
> +       u8 *buf, *flat_tx, *index;
> +       struct mctp_usblib_tx *tx;
> +       struct net_device *ndev;
> +       struct sk_buff *skb;
> +       const struct {
> +               size_t len;
> +               bool more;
> +       } sends[] = {
> +               { 1000, true  },
> +               {  500, false },
> +               { 5000, false },
> +       };
> +       int rc;
> +
> +       static_assert(!sends[ARRAY_SIZE(sends) - 1].more,
> +                     "The last push must claim there will be no more");

This fails with gcc-14 (the latest available in Ubuntu 24.04LTS)
and earlier:

drivers/net/mctp/mctp-usblib-test.c:819:23: error: expression in
static assertion is not constant
  819 |         static_assert(!sends[ARRAY_SIZE(sends) - 1].more,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
