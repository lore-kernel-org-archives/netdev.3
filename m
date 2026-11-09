Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794236018;
	b=Esk8jVyc8bt1ZHPohcACJRbSAYivWghaS1f4T4OCWl+j6gUUsY7acgazFIEjq/kfUItv
	 orMbpYGJc/Rzzxsp3hVBJxG9vvtGAuTGZgaxDYvCHa006dZt2b36s92B2AT0uDGd/TjJm
	 mfwiRfhz6fL9xK6QCAFXKZe9XFRbXcPMQaNyK2lI4NcJ6sk9MEbs2cGTuP9s+PDWOuynR
	 OAoXI3k4dhQtO1H52dQlTqkEr9YknALhRCr0wF32N4fTKwRseH2HCctVtVU8MPNoTiJZg
	 akWGh6fYmHTuqiLde/aX0Hfna7+UyL9lwC06vEBvTV/Sc614nOll/Smjlp62jC2I06A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=hsgjUWa3q8VRooHlY31LuDCJH+v126xhzf92a/1gL4U=;
	b=2tvE91PbuFXOFcM+8R7CKHtrNsexsCIWySTUNpWh0k9aTBq16jh4VQCY1DnU1opB1H0l
	 F6JbtZQHLCvGWPQJ6Y/AFJCdNupz/C3tBnGoQHJOP5c5S8220892S/dzzPJ3b6fJDabDW
	 t61NNUX90viOpRbz+64ieOhDNJfcUmzoTPUJlFb15ZCcJhXfia6T1DdcMIdWhPmXlMSmz
	 jmMaUtkUzbVJ8E6LXW/SDB0GNNTRBkym94+U5oc4SbnylPE7+XYIkFnIpcK6CFwzFxQhd
	 u8s8zRl9DeVN9ETb7yhfCfCcQTC+4KAz3ihXJlz5GHyxgo5+yWpwc8QR/JpBVVglPwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBiGfCXt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234C606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 14:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C234C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBiGfCXt
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-825b40f8a26so400202a34.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 06:53:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794236017; cv=none;
        d=google.com; s=arc-20260327;
        b=B+7yfcQ8hBOrYaqLzt/NGhYXHZEhySzE/xU5AhQcL2txziF5fsZx4lhc+UehMe+MWk
         oSYzBcbr0JRzGKh+rIbC+7np/53YjIcfGnKyAf2p5GF1C0WSawKIIOw8EA2TZZ9fLQb6
         FrZqkD7ZaH0i1f84XzLRO0nmeBVZ0jpGeu+P8gXPGyk/TRRs0ktcKhrgqoCc7lsHIAv/
         z7OqBf0n+7VqY49J3PuHOxEV+C8UP7jyKGsviZiXP6rAxAoY6zDeE6RI1lO67TtykHqP
         VGK3BcycBldqFFSJMqW79l2GrBtfHWDjNc6RWNSMyEndfXWcPI+D/YesHMhcold1LSl0
         OkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hsgjUWa3q8VRooHlY31LuDCJH+v126xhzf92a/1gL4U=;
        fh=apboHd9+R1dvvCkJdZDZKmUVNsbKVTk7ZyeK9b5N4V4=;
        b=hU06B8mchyPPjz2n/vxc/HY0orc+jxbokwKjzBcK0KO+K44+25Xpn8mMPefKsSypHn
         elkP1lQS0wnyUqfO63od8gOEO5+WF3GALJMLzOasXk0DABlKOCDSJlCMRC4W6rT7PPFy
         ottNh4Vz9++Bwx1LsU4qnz2ZkzJIIBESQbQo5uys405GVsICoR6wd0ldeegr2+nciNZl
         BN0tZ+Zaqhrcmm2gKMVdhFLE2RfiI0VBUSWIIinKC+JKYUaffpgO9xWoiWN0TBF1n4YC
         OZw1GmPl8yHYJMl9V8MvK/IrjqUTkwbPmUPtPBIPjz3IOkIFHOkKbcoKmQmMzZd6Vnki
         ZHRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794236017; x=1794840817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsgjUWa3q8VRooHlY31LuDCJH+v126xhzf92a/1gL4U=;
        b=ZBiGfCXtJELjQ87H7qyBIDI9PStceN1lNbG5fmuz+cKEZgnrlK77ClbgtgCsW9k1Nt
         JMHo+xPfzMMTHelIOAiVx5Z8wDXei8yvfZd2Sr8KwsIcRjf7pmk0huuKVXfkuI/8dIhC
         izLUmSaUTIPkPR8OO8H9ZgUemxnAavQCApZrJ33d8vvVOqjLwHFKOJOGrFYmmXjRDoPc
         hVs2rTJgHv/YV/ozQc1teQImSfDNi+fF90E+WV4aF8A05WwyC6nG4zuSDa4Sq8/WYMSU
         PtArih5lwHCCHu/OvoLe4uqbXaFGy3CcxZQQ1vKmCmdwLGbPFGU5mA3CThRyGIX2JyNR
         BKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236017; x=1794840817;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsgjUWa3q8VRooHlY31LuDCJH+v126xhzf92a/1gL4U=;
        b=kqP6vt/0MTk7ugIWcd4qX0kZGmlaTIkU78kMHaTuM1n60ipCfZA327ZQMFgVP841mp
         Gb8C0DN4h3suptmBvmtz9I6+q1/MkVvsBdszePjo155MLt7OH2c0puWyBxt9rJmgpeL2
         2n8D3XPqtvcFx4d66/S+nQ1CDUI1z2HosAtNFdhGRkHXwGa2ZWz/Dl7N6mO5vOni69Ul
         fDcXWhhVfiTW+4eu38flDuw8R68b7+OjqAOHBsgL0IhPiB4y0uTsRRyJ2GwkJ5ijCx2K
         av739u1IxjVUN/vsNDRKJpzAJICJRfyph2WtfvOWIXIX/H71Yef9MI0B45soibcS8V10
         mnkg==
X-Gm-Message-State: APuU4Z8r2Pl2cQpeMJvj8Z8OzMi/13UVonaRokgqy6AN+ErKRBJL4yZA
	zrCZK0CD8gNqt0DHEYi1H/9S7FiQbzOR+fxP/R5U9veqOBh5iy3uOSthsJUHcQWhE36ewlDhwCl
	V6HmsJbcLVz9P87A8pZ5WQ9OSUSJ/Q/k=
X-Gm-Gg: AYBFou2ybDaI5fKICaeZ/whEakV1CS8OWGsdYONbzoA7GP37dAtwA03fllxKYHQ61Is
	6COYD1xQkJOWbmBBUdoTsXnDHgKyfb+7LPTlh0o4K0JJMg6O9TsERCQpeb6wO8rkNO84xgXvo5j
	YtH9Bis593wA/fToTVAwDKUXb1Mje+TuFvVYYJ/IyBn4U0PWNZhu5BOz1rnG1OKGvzT1F50Iv0A
	5LRvUVkKLpJMU76IsDJYZpIXuBjiYByaAAx7W9ZDKvspFuGhRCL3sXOZpXEhOFz/GC/WkD5UdO+
	Si1x0vTUY4aP7VYuJiUQGxU/gOifrlue2gGDvSQdobUun4ZZRgYNhP0jGARLT/V9JH4mGBE1gL8
	rcl1uLszMatBYdvAlAc2G11z37CKUQO7PLhfZ0/kXn3/ZyvnZIo6qCwjkD+LcgS3w8GwA3W4=
X-Received: by 2002:a05:6808:4f4c:b0:567:cbf5:bb95 with SMTP id
 5614622812f47-568141204c5mr3074501b6e.7.1794236016577; Mon, 09 Nov 2026
 06:53:36 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109144705.1737460-1-mmyangfl@gmail.com> <179423591750.488859.16025770326702158514@kernel.org>
In-Reply-To: <179423591750.488859.16025770326702158514@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Mon, 9 Nov 2026 22:52:59 +0800
X-Gm-Features: AclHuK8GlVRWcIBXTah3vZEYSUTseoisYI_J4pmRZs-QyYbT2RYguGW80JIs1pg
Message-ID: <CAAXyoMP5GRbCoArr2CA__ROs3G_PhpQTNq9cSpsa=3cjk9XrGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: dsa: motorcomm: Free the MIB block on
 port teardown
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:51=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

not a fix - explained in the message
