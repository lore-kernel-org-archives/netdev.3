Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7524DEC0D
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617983; cv=pass; b=FJp+t4lDfAjoKrFRICaO5Msrui03bN0sBrgTfqdlIS/XL2B+Afe3zDMNnWKnPAG8Cb+vMQRUkW7D+RHAFxwXLWrRBm4YsEA3Qidmk/YhdWFsXfXjDWqXUoqVTQI+KJfITqDlszF60YRLpnevgDK7cI092eBqGPUtUtx/d+DG47M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617983; c=relaxed/simple;
	bh=qHCz5b6xAGajHWzyuAX9eZwo2u3Wa2NY7lK1Gey+XIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mP9rwzKcVeYoa62/q1VDMIpvumEK7OWs6yCoxDALHGmGgQi1KW/ipxUIKLfkS8HqbMEDyogJcM26O2yKp8dN3WC4sEia0Pz4KDZMTN1eENTJAolVIB46laevoo26c2nm5eQGTAKMID6kkE50PJV3BhhEb3cSBbt7Oor2sVbAmyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H95MyX8U; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H95MyX8U"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso31772135e9.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790617980; cv=none;
        d=google.com; s=arc-20260327;
        b=p6wZwGMOJVkt7/iQPIHyOv86IPPrIBPYCpWzR/qKVQg61+vy1qOZFL1N9LlEnUq0E1
         YMW8fKbqXxvkZobZOcp7Ih82xsKUdeqG5tiMPiDvR+UGUKOJVM0pHVbtc8Ga8nAd6aDT
         xpUkHPHZSrIGGigyqe6W7cync3hKFzfONmw67aN9rh9pgLBhQQCt3P9CP3hTtMrSNKDe
         QtKmbswtdiRCv81YCMDHsp1CpYe4kWCar+aY4vIj0WNoeR1jOPDTzBy9sDI9m2waj/3e
         fQO25mZPD27SpmXfoa3Sll4n1PjKd8KHT7JBIT33Cc4uZfdWdIYXT8ZukZ5LV6Nm5DVs
         Jb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XTXcFGeYsQF5ODY6EM0Lo/8L3sD02ATblw6RMluZr4I=;
        fh=sv6dzx/OIk7BpYXa0WnuZFJcwMoDm1KsoaTzLkpWbMs=;
        b=UY+5w+jWFXdrT160QUNv4FZPZ3Z23Sgse6/wq+zP8sA6L01Y50HjeZQ+GVCxBVKTzw
         EQOVq1V6CemfT3aO4Of1FeugLt3hIozOJeY6123VcoMhsAPpnzCuC/5h2+6glPA4LD+U
         oMSXZZ87gAKvSiwpE4x5QCQ8sZQNbwzgw8pYmQ+HE0R7iB3W30lISdirQiGKk5IeKRgt
         MRxX3EGVE9QHqnc9EUprnd4oIRhSMM03RTVtgopbOgsH+SBBkYHzamFc1eps5Yv10p4s
         /FpYez/82VCYI+f5vp2ifUjbhg9eWI3mn1/Qu0xPx40YE5lKQ4jJ0eXUp7J+l+Ttxokv
         KqXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790617980; x=1791222780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XTXcFGeYsQF5ODY6EM0Lo/8L3sD02ATblw6RMluZr4I=;
        b=H95MyX8UuIgsjxmt3QfZQ4kj+8vSRJZ7HXtaMVSj6uH5/nmuVAPBqBqKDenByYRswn
         Qb/8UtMy3vS/xkF/sVXHSDF7pLURyp470e60QWVUoMr5tVSqo7um1wk8oTyp3j4f/N0f
         i7W9joCBqP40GEItmfyWcGzwDeLSNlKifMFQLSKB2eMDJj8UkaiH0+OsKFZREMIZ/L4d
         ADq0a1Hgl+daVwaEpYBm2DGt1gQiocarTOv21RtWIjbNvW0Bmbkz6waZCtyRIqH4YJqs
         tj1ZpxGDTVH3U2Od0KjONnpkEXqAfZuwkXKlpujMPW8xjoFKnFzKUhsJFHCtkeUEYijV
         wstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617980; x=1791222780;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTXcFGeYsQF5ODY6EM0Lo/8L3sD02ATblw6RMluZr4I=;
        b=WlQWY8IE6Bfvf2ydx0ueO/0SejkP9IQJyNZKdo4ZPqY6+m0q3J+ANpzwbenfuJXRaB
         +MfNgiq2wsiw3WluUSxl/nyK/bG825jNx+3UJPoMDzFVDx4y+iCXicD809PGEv5WQi7B
         qPIBARsAtzH9NWO+pGQzsSZFo5g16M5DmDc1REhFnhQArICnmH020wV68KMpnwJb4MKi
         XIC9vjrMpLRhKU/MAhte73XFBvHn4NZhU+KqldG1DDWBohHNTbpaPfNYC0GhdHUmbx1F
         6dPTgDzJHRKqswWB8E/Tzk/b5v0b4MQs5o8O6a6cIt+DQF8TffaYkxs2++y78coSlcgG
         9png==
X-Gm-Message-State: AFuF++lAOpoJ5UoJpppmU0F5e7wB7y3t/cOkvsg4nD7mBcjSBtDNdGYK
	wxEHzDy3PLIxj1YpdLFnOGwdBePeja1sU2Kwe+CLtJ7sy7ViAl6841Zezpya/tCjGb91EMnLl00
	cg2w+edp4hMwUwN1DJ0XJeR7WTsZDkIs=
X-Gm-Gg: AYBFou2M4+M1twfdmxB8Ahw0GUX7BiK1ALf3mJuthQctUkn3o0XdRwNQsAqDnojN277
	sYwZrR1ykbXl/n3/znX5AwRYpWsod88sn5v1id93l5P1SZx/Kf4+tQYhpl2w5SR+ZKPMV8XVZzK
	nI6GtIyH3zWaUBTdEVSnhdAwfGMrmWHbuMrwKLRS6WH9ihHzNHuHiggRowL93N2+ZiXCeRCEUwi
	33a8f3zePbChBieNcpz4AYAER9HpsKdWsIhTaHzrpnBdw4L7U5Dq3A8WXv5wWihXK6JBtv++2Ii
	mBkMi2SEiPIZfyxFNHCAOgQRcQmuivBxYyaJPA7Ak4mez1ZW/MwRkPEsGkJWX9Y3PsfZkrFLf+F
	HxJGp+W5/EMUlId7gqNAE0f7vtfBOMOWhmnwPkG4z15ggVs/n8dHY3t7mvvi4LasNQ9QuibVzF5
	7GNmeQRH8R
X-Received: by 2002:a05:600c:37c4:b0:4a0:b6:460f with SMTP id
 5b1f17b1804b1-4a001e8c579mr83519625e9.33.1790617979647; Mon, 28 Sep 2026
 10:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179061185153.414394.13396934246780284806.stgit@ahduyck-xeon-server.home.arpa>
 <179061215303.31693.883978833177117655@kernel.org>
In-Reply-To: <179061215303.31693.883978833177117655@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 28 Sep 2026 10:52:23 -0700
X-Gm-Features: AclHuK_cXYijORxYwsAN2ky7C-2QMMFSszXb1Rv8M-Y-Rg6sxebYJ-vvK4CuuhI
Message-ID: <CAKgT0Ufi-wDKY=0MLm7aLP5u0Rp0H=BFsxf-GQFsh=3FP2eM9A@mail.gmail.com>
Subject: Re: [next-next PATCH v2 0/2] eth: fbnic: Update BMC MAC address handling
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 9:15=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
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

This is sort of a fix but it isn't for anything that is high priority.
Basically we had cases where there were noise messages seen when the
BMC would transition between enabling and/or disabling a NIC datapath
which would seldom occur on an active port, and the issue at the time
was very transitory. As such my thought was that this didn't rise to
the level of being something to submit for net. In addition with all
the updates for items found by the AI agents it became more of a
refactor/update to behavior rather than a fix.

So if anything most of this was found via AI analysis of the two diffs
to fix the original minor issues seen.
