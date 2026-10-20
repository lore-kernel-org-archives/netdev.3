Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527462;
	b=lWe30D5ICULIwzUsKZAokLKpotlomWHeOsiNttMmdz5Jbcci2lL7KmNEr/eqcGTdF3y8
	 N4rAUblSHZ3wbZeq8Mi5W5LHuR1vWhFlFd/h3koJjNM87X01Iws9T3+RL5sIaSllpbcVl
	 daxMQRArL22xV1Z1N/Da85S5+2pW2bygVB62siMIrD2navLK3+TKH1buaqZ6GDn9Qkw9F
	 IU1BF/SJBeItYpsUsK8dJrp2hZtl14YPw1KN0QEXqdGHK2EGF0kZN121a87kNDdo33aQo
	 pQa9M4RB/w7GSJaZy6p8R2xHC4nrA7Sdz89En1s6nZz41nGEOAfqTjb+0bfKTtTF/rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=87SiGqQk09gjnLOfFzKbGj+YDTzrcqCWleu/6jAMDYE=;
	b=26wjzqCWNwwnbcR7lqKlsqm6alwahFAQhWYKRiK5CDWYopjA3vQtcvdtPuO6XX7B8vzD
	 utMttOeztQJyHODw0S+rkFGMaSU1bQFbSoQTew2d8bOvpupwzD/QKCyupORHmUAKY/+J6
	 JO7WmQ1tIEU7NIKtU2QieBUyAbDjo2Y29gPcauMhTXjFYtjrTN0yWL8O7AseyaDacMxPl
	 aiH6IGRlSMsOszyfHwiGh8ghh+s2NNt+BBslsASKA3O1JD2k72WlUJHLKx9b91N0N/4kt
	 HhB82GFMm3g/pse4i/too1fgybVn1dmopJ04oZRZoWSgFgFQ6pCnb/BGKWAbyaOJNBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l6HIWozA;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988ED606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 988ED606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l6HIWozA
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-99071945aa7so22406241.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792527460; x=1793132260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=87SiGqQk09gjnLOfFzKbGj+YDTzrcqCWleu/6jAMDYE=;
        b=l6HIWozAGqDhWCAkxJ/R1xXlSDpdQNn5poKVdEauyiertUiVV6jaqa8SMudoqfDL8Y
         gLjc7Ezgxwu1hajRClNGJmqqbxcMOyDmYIgFLVuJKwSJXuesu3CRCEwiOyY8Sv7c5sH/
         cieNHSjGL4XoRg/75Xco4FWzhAj4oPdqnFqxIw1a0mnY5K6aB1L/JeUHwc0apuV6Uj2D
         DtqvlgH9K3E22z9Aoa1CuJ2aSfagdQwPRhYPOPjeQlCcY1NMDi0vjcqd3PYy7pYA3aMC
         dvV3rt5+URtj1yWwAec25MsQ5FrulxkQBWzslMLubWKzIwETo/SYaElDF/NCkgcjTvkD
         0CHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792527460; x=1793132260;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87SiGqQk09gjnLOfFzKbGj+YDTzrcqCWleu/6jAMDYE=;
        b=gs3EOramVP33weltxFIRz8dZojW1kjqq92+gFng3oU+kFvXE+pWa5YUJmXhWsROqoj
         yZX43ScRmKI1pT7cE6aNDKGj07N7FmOqc+YnHmbWUrfwQi48/pVOGFnpX9XT4b0T4J25
         kgyuYjE2zbPgi2PfD/H4la4XjCaoOdlhLY6D3Si6/M4m+CF7Qb0kdxPij9/+Dy3t37Di
         3oCzzkEJORJPX+jNSSmCySNWuejIAR4aO8vCFeZDp7ipyReMhdyWnLMMQnizbL2i2dht
         zVma+IjzQZZID2ocvFf5AOMurlJs7Q6KbeuZ7+Qw6bQcgxHlmWKe77bZndr4JzEPpI+y
         jDOw==
X-Forwarded-Encrypted: i=1; AKwUvBzHeWUZo2VuJvawQemjWxCg0ZwW1pNAVWAC8ChkGuZG/EsPdiwn5DeLI9yHhmrRtC6VEgorrec=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3XtroMgEiP5dXP6MuW7C274Z6si0NVvOr5MLNT9ZkF8Zzshvx
	yEpXdPGVdgN8WOLa3j+CnQy/staOfWhm4r7x9jfiTgHBdUFyXb37CIyp
X-Gm-Gg: AYBFou0N/ms/iIG59z+OXoAnhCxvKzbi0fgVPRp9RG4Ff2qJYaZ/a7AjkBXsZjoEQAe
	SFsTpJWn+ccopGQzNKrDLK224uh+phwsP/kef6m0h8MWwFUJLaVmvkcLmNg2aBo8vXBepHKnTO1
	s/j6bDGf5e8P8qISOeZhwUb+YX8HyPDn8nMNqFvDRzFsL9DYo3TufCy624E730E+vKqahWwfuDz
	c5APuOP8TDQdnjRacP0HecuSsXYAOpwKzRsZty+Rq1EFDoR40Gvop9xrmmg/OhFSSksyk4YuqlS
	Fpn2Sp74w5ELtzyxHw9Ef5M894OJTnINln+P1rvcy10BCcVtY4GnHMFR+R5ITYDb4HuG3q88ATm
	TVl8Yus0nztfFx5n8AQKu2MSGB4nigkRDEyiu8h/aEhzD+DICvTTFez7fhVVXORX7jmm3rT2zq0
	gPF9kPfQjoZQY5CR9gaFTzVcFT2ZVp9ru3v4tRbLx1UMPzCQ1bx5dwtWeZK7WFjhCS7WaEZ5Dii
	qS1/y9HkuI2ILZMU/qVaMNpc5t6Q/ES77KOfN0RX3YU6R3rAMEH7RoW0SZe0PE9fGA/HL7SCxeZ
	DUZkfeo0zG97oyoY4QemyvdE2wtWBKMlQ/sF/g==
X-Received: by 2002:a05:6102:4485:b0:7b3:4199:2dd7 with SMTP id ada2fe7eead31-7cc92256068mr130816137.0.1792527460493;
        Tue, 20 Oct 2026 13:17:40 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d0e116a5sm838405241.2.2026.10.20.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:17:40 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:17:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, 
 Josef Bacik <josef@toxicpanda.com>
Message-ID: <willemdebruijn.kernel.22d6042aad0ba@gmail.com>
In-Reply-To: <20261019-b4-skbuff-bug-on-followups-v1-12-41dbef50b9f7@toxicpanda.com>
References: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
 <20261019-b4-skbuff-bug-on-followups-v1-12-41dbef50b9f7@toxicpanda.com>
Subject: Re: [PATCH net-next 12/15] net: test the frag_list layouts
 skb_segment() refuses
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Josef Bacik wrote:
> The GSO KUnit test only checks layouts skb_segment() can segment.  Add
> two it has to refuse with -EINVAL: the non-uniform frag_list with SG
> on, which used to hit the BUG_ON(i >= nfrags) the existing test steps
> around, and a frag_list member that has its own frag_list.
> 
> Both warn on CONFIG_DEBUG_NET kernels, so run them with the warning
> backtrace suppressed.
> 
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks!

> ---
>  net/core/net_test.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/net/core/net_test.c b/net/core/net_test.c
> index bc2ef7612e7d..12a175268a01 100644
> --- a/net/core/net_test.c
> +++ b/net/core/net_test.c
> @@ -39,6 +39,8 @@ enum gso_test_nr {
>  	GSO_TEST_RESEGMENT_MULTI,
>  	GSO_TEST_RESEGMENT_TAIL,
>  	GSO_TEST_RESEGMENT_ONE_MSS,
> +	GSO_TEST_FRAG_LIST_NON_UNIFORM_SG,
> +	GSO_TEST_FRAG_LIST_NESTED,
>  };
>  
>  struct gso_test_case {
> @@ -57,6 +59,9 @@ struct gso_test_case {
>  	unsigned int nr_segs;
>  	const unsigned int *segs;
>  	const unsigned int *gso_segs;
> +
> +	/* skb_segment() is expected to fail with this error */
> +	int err;
>  };
>  
>  static struct gso_test_case cases[] = {
> @@ -204,6 +209,28 @@ static struct gso_test_case cases[] = {
>  		},
>  		.gso_segs = (const unsigned int[]) { 0, 0, 0, 0 },
>  	},
> +	{
> +		/* frag_list members that don't end on gso_size boundaries
> +		 * can't be segmented with SG
> +		 */
> +		.id = GSO_TEST_FRAG_LIST_NON_UNIFORM_SG,
> +		.name = "frag_list_non_uniform_sg",
> +		.linear_len = GSO_TEST_SIZE,
> +		.nr_frag_skbs = 4,
> +		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, 1, GSO_TEST_SIZE, 2 },
> +		.err = -EINVAL,
> +	},
> +	{
> +		/* the second frag_list member hangs off the first one's
> +		 * frag_list instead of off the head's
> +		 */
> +		.id = GSO_TEST_FRAG_LIST_NESTED,
> +		.name = "frag_list_nested",
> +		.linear_len = GSO_TEST_SIZE,
> +		.nr_frag_skbs = 2,
> +		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
> +		.err = -EINVAL,
> +	},
>  };
>  
>  static void gso_test_case_to_desc(struct gso_test_case *t, char *desc)
> @@ -283,6 +310,15 @@ static void gso_test_func(struct kunit *test)
>  
>  		if (tcase->id == GSO_TEST_GSO_BY_FRAGS)
>  			skb_shinfo(skb)->gso_size = GSO_BY_FRAGS;
> +
> +		if (tcase->id == GSO_TEST_FRAG_LIST_NESTED) {
> +			struct sk_buff *first = skb_shinfo(skb)->frag_list;
> +
> +			skb_shinfo(first)->frag_list = first->next;
> +			first->next = NULL;
> +			first->len += tcase->frag_skbs[1];
> +			first->data_len += tcase->frag_skbs[1];
> +		}
>  	}
>  
>  	features = NETIF_F_SG | NETIF_F_HW_CSUM;
> @@ -296,6 +332,18 @@ static void gso_test_func(struct kunit *test)
>  		features &= ~NETIF_F_SG;
>  
>  	SKB_GSO_CB(skb)->max_segs = tcase->max_segs;
> +
> +	if (tcase->err) {
> +		/* the suppression block doesn't run if it can't be set up */
> +		segs = NULL;
> +		kunit_warning_suppress(test)
> +			segs = skb_segment(skb, features);

nit: if respinning, add braces


> +		KUNIT_EXPECT_EQ(test, PTR_ERR_OR_ZERO(segs), tcase->err);
> +		if (!IS_ERR_OR_NULL(segs))
> +			kfree_skb_list(segs);
> +		goto free_gso_skb;
> +	}
> +
>  	segs = skb_segment(skb, features);
>  	if (IS_ERR(segs)) {
>  		KUNIT_FAIL(test, "segs error %pe", segs);
> 
> -- 
> 2.55.0
> 


