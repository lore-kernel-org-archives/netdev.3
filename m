Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278421;
	b=VqBxgZWLgKza8yqNZjemKxZZ3UJi+eORiK9WG71CRfoYV7zBTQtWkS2Utz1gRf1yYPge
	 3wrQvmBmReHOfrdKyMVag2JjdsGCdEHZFlZS3iHIKy/o/FW8pDvJkJ2psHA7XChF3nmAz
	 Wy+kasXlUGGAKEV/Ce5+a7N9LpYxni6C8MfalF2AJ2zWNBOPDsQaxE0uGqQkVzzEr6i72
	 Gn5o6HiTB86DiuhGTHkkwsvUB/34llZZZNtIOM2azSPluqyfn9Ha7N+s0BQoNgJuIRUz2
	 /CrpBqQ71Lufx2E1OLiX5iVDZXWCl9y+KXCkl590VnN486cS5uUKhYWTaLtLZy4uiKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HM+XyEisFCZIwucULiILX4kMgQHO5fwVxx7FssGS5nA=;
	b=2ovjH0EwK8MgIrxHjfZZnbjVAmqCrp+3/K2RQxjQ4VEaTJcKG/eOM1ujN825JGmmC+Ox
	 5RqrkoRvDXl/siHNQN2tvPQKeoTDGabaGMa14xYEuVgVsUMJ7UubtDjdqVgFs8WNuOsSw
	 OKV3uu2PsULNlfg5rmSIDsbYC/rq0ewtSaaEwPcQLLgw4CDAp/wXRDozBPJY1gmEZ8PfK
	 7XbNWm/jnPo//zAbUD+gTPB+KqnpJMK+SIUhXPbkBmTkQTAzjOgKHmp+GyCGUA3LiUt5l
	 bsb/JmhWG5EErbi6+6H7XdC9W4jw95Zmpc8/ko72phBx5KRnjOuyZ3KG6OORhsFBSLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HSQ5V8k6;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EEB606A339
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41EEB606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HSQ5V8k6
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b349d21fd1so11389257b3.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 18:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278420; x=1794883220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HM+XyEisFCZIwucULiILX4kMgQHO5fwVxx7FssGS5nA=;
        b=HSQ5V8k60WN+aHLL0FYylBzscTr1Fiafj5adRc53D0wzGY6iWf6qCiJjLoWkGwpz4y
         MkYNCGFYnJ/RE9qjzrVBgGKrwDDYCzRKzwgHPlhUSwekzzlHWw9HH+IQNy0o8U+VXaNP
         cqLof6bJnvzxk9HGAwdDf9HB2QeiQ5rfgWL27nHiZjF5rXGdAL7n6JKVOMlrXmIWJ4R5
         lKY1JsyawlU35j8WiIY4pI1kHZUwTEt1zEvj3OPagtrrTDNeUn3vJ2V01YIWsSE5LaKA
         nmPyCTL80jWaMwUNW6ptnKmZy35E3xQIOc1tZrD+1LZszW7GzEidV/hN20MjeTJ/6UWz
         6Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278420; x=1794883220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HM+XyEisFCZIwucULiILX4kMgQHO5fwVxx7FssGS5nA=;
        b=rYunw/faqeJR7EBBkZDVC1iafJtGvjUQP4nBr+UhKzAeN0ncPp5ly1ggeE8E0zFVVs
         hEy2eQu5+ilXRXOoKyUDb+/LfKrHPr4PsWQD/KZlpmICyedVIJDyYOwP4dZQ7MdZchdc
         NeXvphNtjewODepO3tuSxnN5RloofN3HuVbLH64Hzkwa9blzpOxY7AQakNAr9xqBhw67
         yAoa8V2QyR2ozFRJfrOn174f6n5+yhjmvAkolcCRcSGomm4daXhs+bTpEv0A6ty+MJOU
         ok/lRz6R4xlLMp7qEPyiBhgRtNAPcPt6VV1Guaqjo9LIyg8VKNRBDrUcMZTW8Q5A+LNz
         ZIaQ==
X-Gm-Message-State: APuU4Z9GfIybjpiTZPrTJpCT68smZLMPyeMjUQzC3bJbTA92JC95GIw2
	m6jBiuR1OsY11dU80UmkHq+EsV+JryX0r2G4XZR36OqHixa7GzvgAsue5UJuHmqSrJk=
X-Gm-Gg: AYBFou1GDDnIXa4xr7ydWNqk7ZbkCjy1GEuOnGbKQ/cy74t/HHMSNsTaN+HbYUuGkyS
	xFDIoXTJTuIgn5ucDPDXpui99JKy94e6NdkpGsbQVXc76bsK0V6QeUXTZvqwHWO98vOWW/p45BP
	tqFkqfF9JbPO1MW8GUwr7Bvxl89oqpo03sPodifJm8E7WzgHj9eVf/uVWQG8xZ5XVYWmH9juZh6
	kv53fDyj4MVNsF4tErCDX8lWkyTxS0V6W1swdw3ayEV2Y5IXAtQPRrfNvqs5bdLYDJ5oreY4E/B
	nTMWRIM45Fnx/ybytIevEBui62m+9ga978/VVkcxScPKWv+yJHHQuyaAAh9bg3lUPOGJMIfmzjx
	rKdFV5PMwJ0LjRPyA1VygLBVVuu8H6kmt2+VU8tMfV/JR7f98KmQhetXAp7Evs39yt+OjEMlFdE
	oqL0sWS/vShaSacF+dYVXD5VIckGZLYFb/FehHSSQJLrdxHeRww47f9I6s5aqeBZnKarnUNE28G
	Rt83InfQeqEPsBo02cl2zgp4rU2DTZY+BWMsU5OOBxb4zUSKsjejggk6ksTBQyFiq5Y/VKpzolL
	xW5i7hpG2eFNubTT0GQ5y/5IfAu9/1nFFjOEmvx7bu5Uqlvrrisoiw==
X-Received: by 2002:a05:690c:7403:b0:8b3:90df:6264 with SMTP id 00721157ae682-8b39293ba9bmr7395247b3.1.1794278420282;
        Mon, 09 Nov 2026 18:40:20 -0800 (PST)
Received: from VPN-156-197.vpn.usf.edu ([2607:fe50:0:f802::4046])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933e0d01sm9313377b3.22.2026.11.09.18.40.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 18:40:19 -0800 (PST)
From: Juan Agustin Niccolini <juanagusnicco@gmail.com>
To: netdev@vger.kernel.org,
	linux-afs@lists.infradead.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	davem@davemloft.net,
	horms@kernel.org,
	jaltman@auristor.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix rxrpc_sock UAF caused by missing poke in rxrpc_abort_eproto()
Date: Mon,  9 Nov 2026 21:40:15 -0500
Message-ID: <20261110024015.198-1-juanagusnicco@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179427443746.994134.16851409559930782509@kernel.org>
References: <20261106011550.59902-1-juanagusnicco@gmail.com> <179427443746.994134.16851409559930782509@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Critical] The patch only makes the stranded-call UAF a race.
> - [High] rxrpc: race on call->_state in rxrpc_abort_eproto() outside I/O
>   thread

#2 is a real issue but wildly exaggerated.  #1 is real.  Neither was
caused by my patch, and I was already aware of both.

#1, the "critical" one, was found by my LLMs on October 29 and raised
with the maintainers and security@kernel.org on a private thread, along
with its patch and reproducer.  The reproducer triggers a UAF on
mainline without touching any of the code paths my patch touches,
which shows it was not introduced by it.  I will send that patch to
netdev now, since Sashiko has made the issue public.

#2 is a race that is nanoseconds wide, cannot be meaningfully widened
on non-RT kernels, and yields nothing exploitable if won; its severity
is low at best.

My patch did not cause either issue, nor did it make them worse than
they already are.  It is compatible with the patch that addresses #1.
Note that the issue my patch fixes is significantly worse, since that
UAF is deterministic and has a reliable LPE exploit.  I recommend
addressing it soon; the patch has been available since October 11.

Best,
Agustin
