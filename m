Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD0E272803
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636328; cv=pass; b=jjnJhRPMzRlaXTFaMAb4DsDdlxgQcKXiyb/92NCFCI2hJxifsXvibmkRoSaF+TtRHzSe1ua+5wf+BwSl34l6cXcrSd9U1azmTI6j3uLhuLyb8th8NdlZq3asp9haVW6t8qRjWE9TnMn9y38eF+k06qLwO0yZGQ+6Rzj8bOY5e1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636328; c=relaxed/simple;
	bh=2Tss1OLFh74zP/YO6lC1hnEpTj6L5m5wTk/nWpTbZIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZnu7vNQ4YFF3zI5b+jHYlnrNXjY/2Cl+8YJtMQqSGdMmevMYYYJhXieBi4i9k+3QEYB9juwYUjOm4DEe/q7MZQT2DicWUgVkmF66iT4SQstDZ18VOhmIzQElGASNiRo7bDI1715zyUF5n5FrSUNBovP3475M59wSP4taXMrDmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFvh5E+R; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFvh5E+R"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so3492595a12.2
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 12:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788636325; cv=none;
        d=google.com; s=arc-20260327;
        b=KIKs3p8lOMN2aPTu1IhOq2Y+67Bv8WF3yPeuxpHKWjvu4G989S4BQ+ee0NcRdv+c6U
         6xkXvNfsyC4ukrdmeGGZVIh62+Cy6lCLl6GBNT5+i9wTyn9V9NKqIu5cnkqXFQt6rlsn
         mJp6jvh+JyS9bo82wMWXDqR60apjuQa8jkLqlq8axolHUp4bid2bZcZogAyZdPefynH5
         U6ejIc5bu1pK0Q5rO3/8PJINzca2/ikSOV94e/Hc4wW+tl336QTciutY+azloX+r17cY
         zFrm3mvgL7/UkSSJ6j/MB61D+6MIIF+hPgEJgPYqcuqpdMZNoZdHPjzx3xG6fUci+urV
         Lu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Tss1OLFh74zP/YO6lC1hnEpTj6L5m5wTk/nWpTbZIw=;
        fh=Fkt73R90giydrd8KDqgjyLDYpHi+jUbmlQkRWRLEe7I=;
        b=U8yxV9mBuF9ogh4kXrfq2lUyZtGOG1TDk32HwBCb+M5csb4MUVBNIcHZqakQR24Kl2
         VdjYJx/dPj0vZ1JGtLu67ZUOGuWpeyfirOPdlQ0fHl+u/v8BLpKlbOZeD6a4csv5fkKz
         P4wjo5TBqMnMCMwROXnr/YOWCnW9peT3O51JTwKgacCQg+BQgqkM8LSHJLutYFFChNeL
         m4610JgZLn2HqyWT09yWDpJCcmQ1GTEld9NUtVlk4hhuYvKJZp9J8nWZxfRQtMQxWjEz
         +yDrJeCkYty5yKz7A+N2GKAsSyY8qmDQtcw9al2Xv6Opig6U+pW8dnMm6yV7ISxNAZLB
         /vlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788636325; x=1789241125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Tss1OLFh74zP/YO6lC1hnEpTj6L5m5wTk/nWpTbZIw=;
        b=mFvh5E+RfS4aNj0vy+YT58yiX5gXrqVTmIyvgCwl7s4+N8bAysfWJFRiBZchZHSZP1
         xDITBb9j3SypuZd5P0/6K4I5UmMSmoMBIQN2nBHdmVxV5V3xiJKCrfjS3oEchRJgz1XF
         w5WxNlnmLWbZGXXH5v4xtjVDWrsQwi8g0uNekvGul/R5js8SYY5tTcZ8NQC5wqgAl09u
         m/RDe731TzJzY24shmP/QfiGau42eQ1cYicgWaEg25xwFkJaD+Y1lOibwCgKY10QRrKk
         DqiY6wsiqdW0c4ykZY4pnjjC8Ad0sEsZKFiVFQb3B6NJglzTDtxQTdobzJbdWTbqxOfR
         6g/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788636325; x=1789241125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Tss1OLFh74zP/YO6lC1hnEpTj6L5m5wTk/nWpTbZIw=;
        b=mNlCQ7fsXEPM6Odjd/vKORYnjWPn1MgwiRF4ZPXMscyDJE4WAbRoSfz0vy0ImrvMFo
         6/gpzJWkFxePeStqzFCKfHJzEu4/Ye4UQVw2Oawl/MSl/R9W+uUSREkrwS2dia/c/7Q8
         9mij+he0fxVAvTqNVlAM98QF/kPPtnm741Jfrr522XUKioRkVOi0vY3ulKYvdS0gym8D
         O4F8u955d3PHPlc+s4zvfNKY+xTmNL25j4xK+iwLvpMBeES6KrZoWCaK4Raz9PSJD41N
         X+xBDI+whgTq3KEfiTpvsqB55wozx9NLbYE0EGPDToz8/dLTVQRosCCcxUtgOreXlTU8
         1YuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzkvUPmFrvKnwoO+GwwXKb14uOVzRFOwMTc909X82mSAtuIZ5ycxixQ/zV6ySC6M4ghhpNmrJs=@vger.kernel.org
X-Gm-Message-State: AFuF++mRrGyxSJNpP0sblfP7yg0AVzNtouH34HF4doUq6Gg+gEvrXUv6
	aFdz0WIsDF5amz8K4f3oV1HRdWEBUkGlZ9i60xWdTSnzEiStftvwzlB2LknAMemGKkHsqSNPg/5
	XNxVNfM+Kjwh7zCe0CO5Ch+XlnvVgrUY=
X-Gm-Gg: AYBFou0F36IlbF2EDKXpGTImhdlePJLYJAgc3xbVB5Me7S4FqksMjE087yXcn1WXiZX
	v8j/B1i1owISx+SxmH701qIShHXPoMRLn3GbcjtOZ3553o4praDjPML063rc5vfv2a/jIfovsX0
	zZNFzh5BM3e4VlUqEA/GOOk8alnjPgSwMmwMl1+oeYBp1LxXkn5ypVBLdRpNPK9VvEgW4+y5YMM
	/rTxoy7wLUHt9aiFEKqhXXN/gHu6qsDtQrkOqFHv/2BiyFeymMp8T0KaGvLZVuGd9Ftof66Q33v
	sndGmnCsnInxiqi/5BlVlQOP6cM4O+9KySFD7BFyP34wS4RoELW8sKgvC2BSGC925Yi8M0zoPjh
	Yf1ip2MDRCsNj7AcQx6TL8Rb8orPbJ8Q=
X-Received: by 2002:a05:6402:42c6:b0:6a7:fb24:264e with SMTP id
 4fb4d7f45d1cf-6a7fb2427d6mr1836272a12.34.1788636324671; Sat, 05 Sep 2026
 12:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904123843.375633-1-linmag7@gmail.com> <20260905140755.GA2875205@electric-eye.fr.zoreil.com>
In-Reply-To: <20260905140755.GA2875205@electric-eye.fr.zoreil.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 5 Sep 2026 21:25:12 +0200
X-Gm-Features: AcwNN1VaRI4G-HQNxdXx9quUjsgkaAUNPekVT3Kj7muTqDDS35k5taSE0YYNcaY
Message-ID: <CA+=Fv5TyOLB-wWap6PCpMw646QnovtDV6xwqyg9ygpaBemXaPA@mail.gmail.com>
Subject: Re: [PATCH] net: tulip: use mod_timer() in t21142_lnk_change()
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Francois,

On Sat, Sep 5, 2026 at 4:08=E2=80=AFPM Francois Romieu <romieu@fr.zoreil.co=
m> wrote:

>
> The current code may avoid concurrent run (#1) of t21142_start_nway and
> t21142_media_task. It may also deadlock (#2) as you have noticed.
>
> As far as I understand the code, current users - if any - may experience
> #1 (avoid concurrent run) or #2 (deadlock) alone as well as #1 and #2
>
> Users of modified code won't experience #2 but they may fail more often
> at #1.
>
> It may deserve a minor comment explaining either the choice or why it is
> not an issue.
>

Thanks for catching that, you're right that swapping to mod_timer()
alone loses the pending-timer protection timer_delete_sync() gave for
free. I'll put out a v2 reorders to mod_timer() before
t21142_start_nway(), which
should restore it for the pending case; I don't think anything short
of cancel_work_sync() on media_work covers the already-queued case,
which the old code didn't either.

Magnus
