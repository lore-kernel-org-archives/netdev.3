Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58137EFFA
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275554; cv=pass; b=n5HWbZGgsAsw3rOrEqiM0dxPMGvxJgdiZTDPTDQl5+2AVA/JoyXg27mm+E6ZwMsoKV1CZJls4bdBst7aE/aHWR98MNnesEY6n0xi/Kbb2CVEiCcv0GSNIdlbdpPnxnv2GIWg4sxgSRaWvVFSMyGLsKOUomoS6UjVAuRtKDP7HzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275554; c=relaxed/simple;
	bh=uwrqn2UWRTNAkkpabrpPLmI30fBajCWuXndngthz32Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJnXnHt/L/mAUXzzN0zqasKmHQVzPYTwtpcqK20tyqyTf00L0nCSZU2YpaQX6faiUR08JETl307Wohgz90jYYm0BIoCQ44NOdmg/Lv9VHPylCt8fVQ5TmiNnTYVh3W0FaHARjna5BL5UpQ64ecYJ1aVYumbru5HS2cGr+guFCK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xaa0o56D; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xaa0o56D"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50fbd79350dso59916581cf.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 00:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777275552; cv=none;
        d=google.com; s=arc-20240605;
        b=a8jSZRf9v5YdXCLZZZTtDmo/bqvOhAU35AGLCy/AunAqVPn1CPap5xgk7r8bN/M1EL
         abc8NPpSZjpI0twfhWm8w9eEZ9t+26ZMm354xj5ZfI+Pw4kkOkpvZu0q69+UEsmR+3pp
         LaE3OFCklsURor2MR2Hv4HJy0HDRAxDBpmqiiz52vnT80uMiO+oVIbjOW5yUF0HTZl32
         iHSDfXoHUwSdslRwR6ZI/hafVf0i+fCE/pzm9O5qpWwIkW8sgikbeY2YSQ6HG7xPqClf
         b4XzvUse2Ey/bIgavYRXKIReUPP0qijKnb7njDRF+3582ctxDM9Z3j6/LbfGaffT/DCK
         M7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P6SboXPXhAO456wvVmy0PHxGDW9wvsKLh8Nz+079+lM=;
        fh=kFSQQFcEX3tvGKgr5t+Wfys17eNp3/Z/FO5Jea20Re4=;
        b=XHenEccVvTGAyscLrZ/lNVnvD0QdObQHoiu7zaEOLLvGVM55xY4OSz/39+uokA8HaE
         YTvtE+qMVg4An6UeLULyU1q7/9wA2GNUIk/hEebzw+/MnQLGnmxFakasgy9iyoUduyWi
         hgxWlb2tLAmlkNJ6bB7k/95x04Qe3VkWD36bu+XxOOGKFZmH62lBme0tmkKfgtKO71Xr
         9ZcrguwoG94hAx9J4g7aO/1fnXJ10fzH4dNPeiPobhz2ZINbe9m+AaISNtkSN28DMB0O
         GcVWf3KWOupney1adz5VHf3Ay2pl+Yj3JXPvfkNor31kAMhiz9/xgZRO/hubp7+F1tJ8
         pqxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777275552; x=1777880352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6SboXPXhAO456wvVmy0PHxGDW9wvsKLh8Nz+079+lM=;
        b=Xaa0o56DnpDacA0zQSfZw4QnskMKXty8weV9eLa1mH1JBWVMo3gOPrmMT9igWs6kl/
         9dSXKObiXDPSWA1ytjdIHp5ZwLNKaUBDg3gaZyyGHlOqr9e+D0uVIiBtqeHxuzRBRO2W
         fVtUb57gM75uypcCzmnY0J2EtiNdTqa8zXBfgLSHdqiTUfAwdaAL9rQEqVobJTI55cwo
         Ez2AabTEsliSw9KYrYt/qwN4ZLXNrBGdA5Kg7W3BHZriD/niBsAwrrOzB3dCQH080LLq
         pkbBA/zcUJzv5fVFMCJ6wzjAzOuz4JCvJWaYXdA6nUaRaLTFBh6NqHge8XIlP+6ke+wO
         vBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777275552; x=1777880352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6SboXPXhAO456wvVmy0PHxGDW9wvsKLh8Nz+079+lM=;
        b=rBJBd4N2bsudHByLLKg7FCUfBOp2wRj4RRBieVIrf9RAvPMpGPp0VODt0qAEZubfgU
         eZ10hGNu8kEAvuzqPcZMHUt+VdzOTrUC4VEgGPQpVEB8G1U4Z48jlyaZc5scQGtjJ6Ei
         wckj7iBrhopLw6x6vgemwi2RuwhLvrZkOhIVCwvm8x7WErm0ZTttcL5ISh1gM0iKzM7C
         4x+O7p/tsS7eIbPDGNhkAOqPS43sxIW4yddYyBgAIvqyRagRKFLnIng4l20ZGiLADMmA
         JeVPByJxgsWZJImrRZ321uZ7ka5tXoZ9yFJvdYapqCqYkoxVsLN7Qd/DLzBPBXJlJrrw
         /1ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bFoNBlbBOad9WpgOHhAbaN9NUDXWdri66S+8IlOfyqIqzAJ4M4AeyipxHvi2+1t8laNC1pQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZx6VG0Ki/VnmtvqCtXxqLkrcnYqnDHaSCMFAz1J/f/X3+TJv
	LQHFcGleeqKZfDezBEav6Y/cTQF2uDu9jSA74pr+avhIUHKAfPJYiM+9DtsIcUc8kJCsG6ONjFh
	1r07fecEbgQKTf3rqVSdFNB5uIVZ0P15KOoVjQstC
X-Gm-Gg: AeBDietaphJLG3N+tbHJBk5f7coy0zhEnroWk4xbeWhQUVPLtsE/C0Qd3NzfXR2aB8k
	JhPRu7g++DE6Qh1gOxh2Ayk7OR/DOBE0BmBGnhlJouHX8gLA3ZV+DOM0VIaB49EiqFcDshv/WsK
	Uks+xwLvZ51m0NvH08bGVwk/HnXsbzRyXKufwCRXB+DBQjicfHmQk9jmE3xknevqSQaw829jY0t
	xRyAtGQ6+Rblt9QY/6SYwaCcdGySDrmZhdta5bAlNmF1Y/u9BFpJgYpNX13ebcXytReAd3AMcnZ
	51hOGLsmGEdiTH1Lg03wUOjKfgkR/BcLwDEuY8iqNAVj+EQMCuV5e2gAqqU59EHMk+t7XKk3puD
	P2oO6wugk
X-Received: by 2002:ac8:5cd5:0:b0:50f:c109:b78 with SMTP id
 d75a77b69052e-50fc1090f19mr325095411cf.60.1777275551530; Mon, 27 Apr 2026
 00:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424171151.1190882-1-edumazet@google.com> <9a8c7687-d264-495b-9cb1-0bac85a7082a@kernel.org>
In-Reply-To: <9a8c7687-d264-495b-9cb1-0bac85a7082a@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Apr 2026 00:39:00 -0700
X-Gm-Features: AQROBzAH8d3uOC_GwMS7ttaaNGqHKepho8GHr7jStXOt9EO1cxYKoHqfDPEVjQk
Message-ID: <CANn89iKL9=-rLmFWbfeci21y9ySTGSipe=MHfXNbkkpQXLxXCQ@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] utils: add fflush_monitor() helper
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 12:30=E2=80=AFPM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 4/24/26 11:11 AM, Eric Dumazet wrote:
> > @@ -399,4 +400,10 @@ FILE *generic_proc_open(const char *env, const cha=
r *name);
> >  int open_fds_add(int fd);
> >  void open_fds_close(void);
> >
> > +static inline void fflush_monitor(FILE *fp)
> > +{
> > +     if (monitor_mode)
> > +             fflush_monitor(fp);
>
> Circular call?

Some last minute change I guess :/

Thanks.
