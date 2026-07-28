Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB17374A0F
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785218357; cv=none; b=D0k+0Pe9uWOtddASYYMvxTs0D98UF39XzCwXYYf6sO71D6jSxNHB2iOlOEAFebbor5vGke00J+6hdGnhRRsKVrnMX+oscsSevqfBTkH6tBOjI9oWO3AIodrL9XGHJQMF/oWzNNugbYkADWgTctpDzhbHGwcpN5ZPeTL0MoaCWu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785218357; c=relaxed/simple;
	bh=/uEnhCDL7SCCuyNWCQ36kTFHnO/TcigqDj7SZJp3+xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXGqYGvqqaaTuFyi+NuVlvZBLzU4nMN2Wydx7jrreZ9p/ax5C/k+2NpKo7756XesDvzUh37mXYAj9dJwpbn5No6kfbSxg1QeIfBEx1gmrQaqSPDxckETfYUKHrMmWXOnropdmE0GUrQWS4z4H+13+0Ze7IwoAjxDTiEUfFn48Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYQjmpfZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYQjmpfZ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso2389804a12.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 22:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785218352; x=1785823152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5MvRezEXEt2tpdeT5IBYM4ttRFhGTd9NFJNVr3eXdD4=;
        b=JYQjmpfZLqKvXSTDIh4ct0NdFuScJd6PvS7lENd9A1FBsPF2VbtxfC+D2FY/HZN4el
         N8Ikvw8VH2mdcF1KBRomEnyDGIsjX0Wv/kXSiPx9G/v408sL8/4j3PpZaujv19TT81zC
         LAlIRKN2q9x7nQLs5QcWRuE068rerHUHh+ZTyGieA+Vm6VTwiMbuAwy8y2ILIw/84QjS
         YnLMxUm7khFLuFaeKJT/bG/SsONV80+E9osLzheCQ9S0bTximLPzL1MbuRNQOzlV1QLk
         AIN3LC3pI5Db6k4t1/VufhzKAI1MLqNV62iqOwHuwMKTGRNYo7sZLlYn8boD8RsAgHVj
         JJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785218352; x=1785823152;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5MvRezEXEt2tpdeT5IBYM4ttRFhGTd9NFJNVr3eXdD4=;
        b=NTNLVnKxuXNYMIeUu/qjnGYbMbcDh6fjOnAzrXTPd11ZZY50LprJG4FgGuREm8HJaU
         B+hF1Zn3tq8vFKX8PA7XTymZ/hSWhml9fn+yOJrKfTFbqlQQYtDffvphHZ4ChncXLhW2
         hnMbtnEZAn8LStA8MRom5lw8uwPgvLZ24LaUf+tByT7gUtJd2mAHChNmMxgwG9lzwvO3
         eliQdyoU0PrXc+E4ClLzcaMKgPc0gmmkGqb8x6DWIvOm9J7b69FCQGSrmqOk/jyABA3s
         TQnNu1Motm+d4cMaewqw4dj7a9Ttc3Ebu/D9i58TJB5vD4Q0uaiYqFVbcb2aOELS9zrx
         Iwcg==
X-Forwarded-Encrypted: i=1; AHgh+RqqLzsYTgbZzxmZCMtSzpvsYHnHz8FTzxL4YaMfeibWLfESIDh6uA3Ta+j6RILEpxrCH6p8DGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyyEIjKnuKX+nPZQyYHmcaSnbQ7qoMUHZNk5/7rOFlkYTeU9Iq
	pbMuyc4PtG/QTuu4q98W86oyME0omiEnMBpj4Z4/VOTUlbmoqXeXRmg=
X-Gm-Gg: AR+sD101ySdOlv+MjvypKyw9gmdTwy1U9fE8XTUC4P2CYAMZ99+7gm6cbHLHGChd0BG
	9rgapSQSbcP8ISDcPcJMhNE6Da61n4sauP8r15U5ppBcZmDR27nbDjxF4dzuBlkW6yIZ+x4T9rH
	KoLE+TCpx8HGE1c8zmcKXy1XkFivprDfWQF31FFQAKGsOVfbiVb05OjkhcZYoC3eu0POCqFdEFY
	D9mzgz0nK9ZVCePADzmOy/FGUXIr574XN0phoUiHUFMj27ddVGQjUfQqQOqIR8OJYDWSCklmgiZ
	Q92WD05pMzdwTPTrxIda+ROk7XDJtS0NDC8ZkewoqPjbMXK9enS2YGBGWUbNMov8kkp+l0inNNe
	FWuWdBKkcqtRvxz2BlfQzy1XY5AV1G0LDBMq5Pjs8x7PJsbh7+bwBrxHvOLP7FsnMofiKS2Qwi3
	kFAMSP
X-Received: by 2002:a05:6a20:2583:b0:3c3:704d:57c4 with SMTP id adf61e73a8af0-3c8aaf7ce69mr1407941637.12.1785218352478;
        Mon, 27 Jul 2026 22:59:12 -0700 (PDT)
Received: from localhost ([2405:201:8018:1843:d15a:2306:abbd:ee25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130262d2sm56009356c88.7.2026.07.27.22.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 22:59:11 -0700 (PDT)
Date: Tue, 28 Jul 2026 11:29:08 +0530
From: Ayananta Paul <ayanantapaul@gmail.com>
To: donald.hunter@gmail.com, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation: netlink: fix spelling in
 tcp_metrics.yaml
Message-ID: <amhElJLQoUJE3lwA@ubuntu-btw>
References: <20260728052507.9954-1-ayanantapaul@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728052507.9954-1-ayanantapaul@gmail.com>

On Tue, Jul 28, 2026 at 10:55:07AM +0530, Ayananta Paul wrote:
> Correct the spelling of "reordering" which was incorrectly
> written as "reodering" on lines 113 and 115.
> 
> Issues identified using `codespell -D - -S "*.bin,*.o,*.a,*.so,*.ko,*.gz,*.png,*.jpg" Documentation/`
> 
> Signed-off-by: Ayananta Paul <ayanantapaul@gmail.com>
> ---
>  Documentation/netlink/specs/tcp_metrics.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/tcp_metrics.yaml b/Documentation/netlink/specs/tcp_metrics.yaml
> index 13144aeed31a..dddf92bedc4d 100644
> --- a/Documentation/netlink/specs/tcp_metrics.yaml
> +++ b/Documentation/netlink/specs/tcp_metrics.yaml
> @@ -110,9 +110,9 @@ attribute-sets:
>          type: u32
>          doc: Congestion Window.
>        -
> -        name: reodering
> +        name: reordering
>          type: u32
> -        doc: Reodering metric.
> +        doc: Reordering metric.
>        -
>          name: rtt-us
>          type: u32
> -- 
> 2.53.0
> 

Apologies -- this was sent with an incorrect \"1/3\" label due 
to a local git-format-patch mistake on my end (unrelated commits 
sitting on the same branch). This is a standalone fix, not part 
of any series. Please disregard the \"1/3\" in the subject.

Ayananta 
