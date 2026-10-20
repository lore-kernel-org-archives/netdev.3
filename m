Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792529768;
	b=yWfvLC5vrS7MCtNKJv/eG3vW6DDywiACl/1BVYulKxrG+tOFFzfO0bCtZw+Tp4IIdADS
	 pwx2UbLPi8WRBoNnUSqN1oDPkeoj14dXU2aQHY9Lpahkq1x+8n7KohaSTEf/dnij//prv
	 dtzpYUWVXEWVw+EbjyMv/LXi2cZUgahFrdxsfJcNSL0OMtyHLhhr5iOLyi+AcvPDenbiQ
	 BQQQ80yyoWtp3NjCvf6sxqpxAI+RvF8el3QbqQvsq7XdwR7LqbRtsH1YjE9hKv8/QZQkl
	 g8IsLrGA1aw/v7RvSJOiaq2pvw4WX73+mwolvJS1CefkXC65hrByVZVsYt+rZd3qCuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=sl+ao6jj/EJqVd8mitMcxYql8KlVrUDpfsHnTJtiC1U=;
	b=wtFd1jCjffDWeM3Hh44ZiSM7JTSzkETVjesN2EG43PEci5iE09D3yuX6/TqpoxXPDT8o
	 MabhADSe2/KNk65bdAOQnGKlPo69ZtGoFb+/DpZbv6uzv9N/izeIUGHXZ2+Rr09DssH3W
	 RYXNwTKc0GTV5Gz4Dno5u9sHHs2oanPjdzWUZXrOfmz6ZFmzD9SY+FtERBlfUeF0SsKlO
	 SL5EmsbUdWCoNn/rXOTEvzKwD3yvXEluvO8RPK+436gDzEu3oATIS/fl1aQx2LYYsnALC
	 S8LY8OqamUtmvtf8TMGV6wCmLJxFIEbxGRYJQfJA2M3U78Sw/L4FFVF1VHw7DwL5yyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nuro.ai;
	spf=pass smtp.mailfrom=nuro.ai;
	dkim=pass header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=QBRGJsiF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1753606A326
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1753606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=QBRGJsiF
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36681e85e87so1658490eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792529766; cv=none;
        d=google.com; s=arc-20260327;
        b=kqHuAg4kJb06qivwkKsQgNpXrhqP2J8I1wjbs6ZgHOVmyjPhPMwbG7/mpsEHUV9hd7
         aChvn2EgmCSpoAaBCs3IM/aOxqxnwIT5KstJSIHeBHxLok9izoir6mxQn49z+dp43Yn2
         BI4NhVyWdSGJCaSGpB2MtqdHeHb8n8AG8Kh/E7yG7gIHnqN/wQaZCMK7jG7UNqPVmVkb
         Cp6QocZUjunsxWpIcVneW8zOS970qAfAeNmHvbj9Cnnxl11mtHf2x9RI3PKeSUh4mYTE
         h8Mv5cUrRNb+hxgYfDzxFGgM2ycWAeMwWK9QfYYSFdpmdZPG1LP2YrvRX3U5DCw0pPps
         1Wpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sl+ao6jj/EJqVd8mitMcxYql8KlVrUDpfsHnTJtiC1U=;
        fh=g08+9vh1/MP1Ck6l+7DhliWxsk2afdR2+6nrlAYFSxs=;
        b=lkspImtfwTPdPfqY1t+86VbCZcSSVK433NwqGz/24nm7+dQE1LpCfs+m/UiX4i0QSw
         uoj0KGgi3EXD3RD/PAJsWwyEbBLuo5CELoPr+3uklG0Nv17i/snkMEIdxcIT/NgOnEor
         tsW/+Y/T6CBhf4zWhFZjeBu514tIxiD0Chvv/nyA+dIrTmDp4za9hwGc7XcjW9EdUM++
         fUCSAKZew2l3splsfu7w9iQ/oFlitgjj3dw5n8WzZfSCW8qAwhWGS9wkhPv3RLbCNxNu
         H4+YFlPRH0uH95g9fdvg74BF5JCKqbXM6t1Ii4J43I87YfpCDDo+u7sSqHB0bY8ske/2
         bRXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1792529766; x=1793134566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sl+ao6jj/EJqVd8mitMcxYql8KlVrUDpfsHnTJtiC1U=;
        b=QBRGJsiFVCrhjLHQvzC8rKPKju2tMSUEZizd5uil8TnWzE5VZgOBqrQt1ryDvFovu+
         mRLoS0MODyFyVb1MCqwomuFE/+I146dY0fGUEP3Qh9HjZMMZLN4Y5WoUdoW+7F0znGRq
         +R+hmZxocYsWRXq7Ai5lg6Kb/FEo1MYKz4C//WSLH+ueMcJzpVCeH6PHuWrzWxkPBRP5
         SxXMfXPaZOMPD+YTfZM8jyxMJPtNdF5T9eH+IbjBZMr7NDog22z9XBDWQSNcCpaFslMd
         0VQAVBS82DXGsbrjq72mkgfNk7Jmk54xrksIEPzKb8PpJSAvUcO1OSIkCpPlGleWA3o+
         p6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529766; x=1793134566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sl+ao6jj/EJqVd8mitMcxYql8KlVrUDpfsHnTJtiC1U=;
        b=gTDYJ9G6EJd5wRUapaGjh6Pq1Tf5UsqAZD4nxsS6aa/of0GCpTXvok9K87cdrzjpJ7
         h6S0xmAIWcz8kyZQdSR6/1xy0MWBRLBckDOQp0jFX/HL+VD/QHbLXh1YFtYuyIEOz218
         qdQW+ryXc1duhHMT5g/hpxuXl7d7ICwceEoD6Q9U+82rOsZPbXxmlGLEL0fm9kk9CCRg
         47ZEQDj7yChq3O5GnzMYGG/Vbgk2ELHiE225omtGbP64cuhakq/uIiF5FDVIZwjqGEoC
         9fXh4b6NI9xRXyD+8BtHoQzMnK81X57m1zTEOUZxA/AGdV3k8ZGqA07vE+2IhEf9RN1n
         cseQ==
X-Gm-Message-State: AFq9FYK6pa1RFMo7BYkr9hF77RdoC7ea6Rh6i3lNY2RdaStXGF8ac9VQ
	uMM6CfR5/VvGMaulAL64p3Ozx36mPdYjiIbphayLXzEkIIOIHi1QxZDo5kCqMYvdCJCHw8EeaX7
	IMj2mef0o5lV7le1vITE70cMZskcrhROnyQgZblKzRQ==
X-Gm-Gg: AYBFou1Gv3G4rhE+HI6i9KTJ5LG2g2dkgP0VtnqcLi30odSoIB65r29iqCICm9g9vIY
	8UkWnemUgBj++90DIvOrHAh83Dd+zc0JWf0EvHZx2kXRln/WDz23r6QHX5gIY66js/MnSitGxM2
	Tv9IdyYom5HFbslUt2HbjG2qLPx/rElYCiJOD9jJqH+a3eNzRRxC7sEZOlTe5Q8ZbWQcSTEbns7
	suJqa7WpUlEKb9fm4BHgIEvu/gjTPcsr9d/8sS5Q8cxKj+GfGthS3rZVYus7u+2NExBNOGLwcQG
	acB4xxAOWYZIrWpjzIDjGuhvNyetlZNFj3dJAcyKcD4HsTgKg88idFtu1KI2uPs050iSd9cHnaO
	HUV9uxsDHxFzPKOfcIFY9W627DdrdZvLQ0Mx+
X-Received: by 2002:a05:693c:60cf:b0:353:8205:8558 with SMTP id
 5a478bee46e88-3674b82ad86mr744900eec.5.1792529765608; Tue, 20 Oct 2026
 13:56:05 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019174258.1375583-1-jkain@nuro.ai> <CAL4WiipkRkOnc_QJ51g6_9uB=pTeCSp6U8L-YVD2ytuZn4g5Qg@mail.gmail.com>
In-Reply-To: <CAL4WiipkRkOnc_QJ51g6_9uB=pTeCSp6U8L-YVD2ytuZn4g5Qg@mail.gmail.com>
From: Joseph Kain <jkain@nuro.ai>
Date: Tue, 20 Oct 2026 13:55:47 -0700
X-Gm-Features: AclHuK-crS7z_XIcQyguixXXCUEme6bZ9BWpgUYG6WSh9lO_ed8dYy8vP4sPrPk
Message-ID: <CA+Y90Pg5UaL9WkaGghc3PZadrsN+ud-vY89aE3xuZ3UjUxz9Ww@mail.gmail.com>
Subject: Re: [PATCH net v6] net: schedule a purge when the defer queue rejects
 a free
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, 
	kerneljasonxing@gmail.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 10:58=E2=80=AFAM Eric Dumazet <edumazet@kernel.org>=
 wrote:
>
> Say not to very verbose changelog, that nobody will read.
>
> Since commit 844c9db7f7f5 ("net: use llist for sd->defer_list"),
> skb_attempt_defer_free() increments sdn->defer_count before testing
> it against skb_defer_max, and keeps the increment when it rejects.
> __skb_defer_free_flush() returns early on an empty list without
> clearing the counter.
>

Review bots found that:

1. skb_defer_max=3D0 still latches.

proc_do_skb_defer_max() publishes the new value before it calls
static_branch_enable(), so a producer can read skb_defer_max=3D0,
increment, and reject with an empty list, which skips the kick.
__skb_defer_free_flush() then returns early without clearing. Restoring
any limit at or below the count that accumulated leaves every later
producer rejecting on an empty list. On 6.18 through 7.0, which the
Fixes: tag targets, there is no skb_defer_disable_key at all, so there it
is deterministic rather than a race.

2. The kick does not coalesce the way I said it did.

trigger_rx_softirq() clears sd->defer_ipi_scheduled as soon as the IPI
runs, before the list is drained, so if the owner has BHs disabled the
next rejection sends another IPI. With use_backlog_threads(),
kick_defer_list_purge() also takes sd->input_pkt_queue.lock before it
tests NAPI_STATE_SCHED, and on PREEMPT_RT that is a remote
spin_lock_irqsave() per rejected free. This series started from
sd->defer_lock contention on this same path, so I would rather not ship
that.


For v7 I plan to restore the empty-list clear in the flush which covers 1
(but was dropped in v3).  I=E2=80=99ll keep a kick for the case where the
owner never raises NET_RX on its own, but bound it.

The bound is what I am unsure of. Kicking only on the first rejection
after the limit is crossed costs one IPI per overflow, but nothing
retries if that one does not land. Would you prefer that, or something
that keeps retrying?
