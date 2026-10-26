Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017340;
	b=TK3dGugHfbwo9cjUseEALnE9/gWtGlsBGin5m4xQmU5E6/iV9w8kyQ/tF8cLO/Zq9nnx
	 Jr6EPGUvqokZdS8g+WkIH5U1ISysmY+5yYNpDbi6OYuQjJkVVNsYJ1TZYvAE7XaKSmn3g
	 Paoxha/CDOhFLHCOR+rpAcJDpzcd7LPHHZAwaJvRbeNNXjf157vU+OiDcXHa6j81WPfM8
	 ys5f48UgZu0nnVXVZISYvyLcPOs5t+PPWJaiSHBtB9dOxJNHvoSqkj/YxN4sn37swbpG2
	 dnLj0ivt+eeTUpyhgN8rSe6d5RgOYjyBz7fsqQ86+c5e2TpNs3g4t181dmAQwtCwgFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=PJP1r5/GuQZwv1AbNOj2FluY2esrMbEg2unT6FQO/Lk=;
	b=dF+QJIOQbtb4SUWP2sh9H4UY2+F5N5Vu27C7W+S0pSnkYu4Hhb5YPT8K2zTQlVZndXz6
	 xpdpdXLWlFe5iOVGazUcZhegGkiiaKWB8IluLpz2sTOpriwZSiJQLFnC6KNyT4hfe78xz
	 WTRQ5AeBaL+t1zQPaN6gBRDzoZyUI3hcbkOIf5hhZOYVvmR/TqVfHCAe+7TtPUvnga63r
	 jInVt/k09wPUcg4Pclw+knM6mAho8T6fG2Q6TR4X169ltY+hR9tGMuI+nLoBZM3gGp2pL
	 n4WGHs6MV/QmVjaYxswaFe8LfZiCP+hbExygkQIKsu4gznHvjX+LVI5LXgE1VXFLiKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hCGtBGqE;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9CF606A31E
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE9CF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hCGtBGqE
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-98c8cbdb9daso535219241.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793017339; x=1793622139; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PJP1r5/GuQZwv1AbNOj2FluY2esrMbEg2unT6FQO/Lk=;
        b=hCGtBGqErUXyKcyFDWAEr7zieuwbCnJOQBfQ+KEuf/wRvp5C3X/kvgufga2Fus3+TI
         JGvipk6tTyEbL/E5aW73SSvEe46Cc5fwK25STI3XHB76CJ7oVUTx4+k+QlICIwJ7xR4B
         9wtDDFaj95vZWxTPnw2fPHJ9456MDK/plNxng2ACXpQia0w0tHr7Ygh8eKvqL7VtB6s+
         itlo2eDi5isgYaTFl9gNq3whanasFKQCtSv3c4BQ+XIyKxh7oyon+Pv2QcDti2TLC4Wf
         yoFC96+84vfjDF2noO/psLKp5R1CVDzqO0xTrGJ5Hid6J0eL74xYmmKahcui4IMSqr7a
         oeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793017339; x=1793622139;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJP1r5/GuQZwv1AbNOj2FluY2esrMbEg2unT6FQO/Lk=;
        b=yKyEI4rm7dTVpFIzZGsb6GpL0Dtjq9tHQmUq+2RlAJzo3PiV260OaUrvUUYyTb1ocM
         0xJ95BhYeekOFiBDKsMuVCsIiTPCknSaMA3sYCKBDlxJNK9VYWx3xRQnahX0l71BLOfz
         EonaTFJqXlY0zSPbc+2xYiqgJtA1aI7BN2Jhpume3zEdEPtuB1fBVIU5MjOCnDQo2bbN
         LnLr891b46DpHE55VRp2apGobe3HS6dnvYZ9p+QnzqxjozQq8CaAH8Dg2zTaGUInRdSG
         pqEiUCbLB08/915ytcU7yFp90FLMTBGolrT1S2TiXKvNKm+zejBFy9RLnJY0Z7hpVY4M
         NX8g==
X-Forwarded-Encrypted: i=1; AKwUvBzCPTppNDd/gCUGIO5muS/dZO3fiYl57MJYJL6fmhVn8+SV+h27M1WnYoXAS2NliTgZb2LG3/c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMer2rEF8oFt03cRamzn3LNEbVcDY9X9WcL13Cj+SxLXVFLRFK
	d9yLf1f+ru8r/bdvOpWJABcjbV9MmPrmA91gAnDgdfnAlo5DD51YlOSM4nPhAzFIo7Y=
X-Gm-Gg: AYBFou0VUDxLllXRuW7gtK65iuuz93V8ynR5wMAiM3+qrO5n/NYC9iS8z9Sqy3UhUCo
	Fd49E0TFXDAQp5tG1vKrlDRO9/AzD2Xf9jAIxitqMD8xIxqQJSIt9JVsd03dc/tDKrhGDNKTWJ1
	QJG62cPMHSH1MHtIqJkvEeYW6OYhq+12wcNz+qutrv5BE9MW9esfUXyjMW+y8GOZixgHuoE+xZw
	CHQHMdq0LDirtnGYLolLgpFKrELkCLrtn9M935TferZrOuAij6BTJInK9Nbr4My5yEOmYOXsA/r
	XNr1JzIk8QGeYsaN9kB7LzQ6gQlSBRyhWqy+xXVIA0PpUgjRje9K0Waa4iWkr2IEOWZD69oDIZ4
	yqX/20XzTxtNhcttxhFXHe8NyTxYY8b0TytltiqQN+Jfet77fj4hWmipcg/4QwGF9sj4/HGi66u
	LekVrLKuP6fmkq58uTLjt0dtie7C/lwItddoChCV6bQ1n6/En8llJ6XC/UbJUceegbKqLQGtTtG
	Md+0d3ByMPgGbyTsrHzjF/3lkpQ7juiXgs2DJcwTHdGpNFDXzaDnBI8JHl7PPLkUz4kApJ/fOXu
	HX/QhMa4iJVvsjEpKcDTOxosWGKrhjdj5ur3WFfSd3fRoENYamDsMhMdkvvsannHns6LTZVcYYe
	li5L8SVtF+derLJFC40oVA1cfKtJdSFyPjOjpPgW/ocRJoNtQ/usxFvttQKmKVBI=
X-Received: by 2002:a05:6102:14a3:b0:7cc:28a6:ee1c with SMTP id ada2fe7eead31-7ce5ca1e4bbmr1974187137.2.1793017338558;
        Mon, 26 Oct 2026 05:22:18 -0700 (PDT)
Received: from c.1.0.f.7.a.5.f.d.4.6.5.7.e.5.4.d.7.3.9.0.c.2.a.3.b.1.0.4.0.8.2.ip6.arpa ([2804:1b3:a2c0:937d:e94c:8101:376c:4b55])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e6cfb52sm8155548241.2.2026.10.26.05.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:22:18 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
 Guikun Yang <yangguikun19@qq.com>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net] net: mctp: free reassembly head skb when key_add fails on SOM
Date: Mon, 26 Oct 2026 09:22:13 -0300
Message-ID: <179301733329.91976.14585535037608378942@gmail.com>
In-Reply-To:
 <426ef7428413b8d05b6cc3ac22e24b1927ab5aca.camel@codeconstruct.com.au>
References: <179287946888.17431.11219154409333681184@gmail.com>
 <426ef7428413b8d05b6cc3ac22e24b1927ab5aca.camel@codeconstruct.com.au>
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

Hi Jeremy,

> [merging two threads here; Guikin reported the same issue, around 12
> hours earlier]

Thanks, I hadn't seen Guikun's report. If a v2 is wanted I'll add:

Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/all/tencent_43A65D51143E18518EA968DF9323694EFD08@qq.com/

> We could just defer setting skb to NULL until the mctp_key_add() has
> succeeded; there's already the common error path that cleans up any
> remaining skb.

I think that one needs care. For the first fragment, mctp_frag_queue()
stores skb_unclone_full(skb) in key->reasm_head, and if skb is a clone,
skb_unclone_full() frees it and returns a copy. The kfree_skb(skb) at
out: would then free the original a second time, and the copy in
reasm_head would still leak. Taking skb back from key->reasm_head on
failure would work, but the explicit free looked simpler to me.

> Alternatively, we could change the semantics mctp_key_unref() to also
> free any pending reassembly, but I'm okay with the current approach of
> being explicit about the state handling.

Then I'll keep it as is. Let me know if you want a v2 with the tags
above.

Thanks,
Joas
