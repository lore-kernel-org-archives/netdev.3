Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF43E352021
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 04:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789532618; cv=none; b=mq2DRSd1w+A63fC+JuzJsQEyNtFSnlgt7DDW9PDPYVlKtO7UzACr8jvrqY9R6JPYIckAhsZxbDOw9K8WV74z8cg3ghxWdB7eTeRD0YNX8gwYf/1HaMSTB5cdn736gvqdYI7ba9b83L0rpEoBHEePGwyZwxhgS2pxIJqZ+QxxQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789532618; c=relaxed/simple;
	bh=QZmwRyZaNMaBsYnngARNyVoFzF84rPmGiwG/pP0Feu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4jbjaegYW71sZFkjyH7k+eyBUpUfXpHa2Ls8pZGxtpdyc7g3hS+8PAtQ/pPGQ/BltXsviBbLDQh4wVn09LdTj33yxmbTBWIxY+d8G8KoUjNoJ3+bOFLto4n077Cka2WPNefrQArbScdTq+yxV/1P2iWqLSz8oaQVHn8so4RRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=E0rx3YRr; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="E0rx3YRr"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fe517774so6065355ad.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789532616; x=1790137416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EYABSkSS26EMkyxvyNh64zgwhUm5P/9St7X6gtjIBRo=;
        b=E0rx3YRrgPqu4iyJuJF6lIkjWmS4AMQWCUExZocBYjqiELunDVJW3IG5NKrQX6p5Tl
         QF/Z85qMudNRkzs2rjR4bf5cQBDyIwTDZaqtSTxkA10ivcYt/ipHTE4Ae2W/LbudMx6F
         UVHKw+ZoFGh+FM293OlsAuOx1QvPEIclB5exFhAvNb45fBk2FTTA3TACdk4IeVus3hFp
         Hgp4eangk/SCMAOS3Kzzln2XdCHAArx5+QRVfdwSKJhSGDHn1fldjfCPCVjg13g+tp1X
         FcSSfKZmQINLJ4I4C83Pf5Jn7Rqn0fhdkOlYycAGi4sQ11fanSjkcNFFxoffpDtt/yAd
         k7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789532616; x=1790137416;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EYABSkSS26EMkyxvyNh64zgwhUm5P/9St7X6gtjIBRo=;
        b=QjziPMLGGjDQalypQVNGuia3MRoRWuP2wjpJeevRmzDcVv0gpryLYgYUtJtc7Yd4wI
         rDb8hM5Pn3DA3evFezO3+lWFyPEWUSxEXsKavDYOIAhNnXaboWdcAjIJfQx6XsHbvVeP
         08JTo7B++B/fMFrh99DZA9SraZKfU4iF33zYuxso7L5G3YWD18fgdLQ6kNUIiCEeJJy0
         FeSwe7UULY6VBEK9LoUbClnl/PgqUzJExsuhmBZUJLx1tUCvbQGRGKGERW39rdizEx8U
         Cq1LOC24ko7DQm/I2qEdoZCxHOT5Bc956flmn+fBj+pOgBwxPhotq4ew5jjlwuOw3yfp
         4Wkw==
X-Gm-Message-State: AFuF++lSYGcxLeEjOJpvuy8L+urSoCoIRoKSN6sQ1K/v2onrKZVNlnfG
	ntNpe6Snfc9BzVUAVZQYUOH4ItKDbgCxH9jNy8ZN8CGm8yIXQrDtVYl436EWMVZ+v/80kJwD5ni
	EbOFf
X-Gm-Gg: AYBFou0zdb94+fWP5vPXTwQftZk4LcKc4Q1kbyvIkJI8FsH2wHwwD35u2xLv87/xRXo
	H2gZ0ENZ1LFL5yy1KbJUtQkXI4Rc2jekWMQb0rHxpUDAX8RiFmgm40nxgeSQcy7wIKTxmcdZhkm
	xhsbKrPKF8VzxaN2p4eb/A+EpMWm+SlmE7zr4eKuWjk5Gfybu+uT0ZyCwSp73IfqX/QdDJiV4zq
	DuLmgZzgJm6zWOyIxwFeIf35+isq1w7clew1KPQWDbwYLFOqUxlSdlYNMXz9FFIwRBkDD78R8Qz
	r4xOt9yVvEvkGRAmSttCnsoDsoMsX2ZW2ze3t9ET1bG3hUFdeYrHf6iuyjCJRObQceD4m5u3Yah
	FKCJCy69Ok5e0FLBN1gI2aAreBfhMtftc+TFBbX5V5o7jC95t188dIEVtj5T8KXUOfUNbgzCuFS
	32zcTR8loz1s/h/oyEZSeUnN061DYjUHOpqJbqwmSNS9ig15RP6ozl+4i1Yix4/rJGAkO6DAL45
	O6CMfOMNbeK0ECZHdPR/OhFG5T+4vE3Wl/LpmTY
X-Received: by 2002:a17:902:ce81:b0:2dd:64:12ac with SMTP id d9443c01a7336-2dd8e632d3bmr19476045ad.11.1789532615894;
        Tue, 15 Sep 2026 21:23:35 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f2d5ffsm4411535ad.81.2026.09.15.21.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 21:23:35 -0700 (PDT)
Date: Tue, 15 Sep 2026 21:23:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Harshith Hari <harshithhari000111@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 v2] ss: add -P/--process-age option to display
 process runtime
Message-ID: <20260915212329.0d4f31f7@phoenix.local>
In-Reply-To: <20260915213100.77691-1-harshithhari000111@gmail.com>
References: <20260915213100.77691-1-harshithhari000111@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 03:01:00 +0530
Harshith Hari <harshithhari000111@gmail.com> wrote:

> diff --git a/misc/ss.c b/misc/ss.c
> index 6c32455d..6058ca29 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -56,58 +56,58 @@ static int show_process_age;
>  
>  static void print_process_age(pid_t pid)
>  {
> -char path[64];
> -FILE *f;
> -unsigned long long starttime;
> -double uptime = 0.0;
> -long clock_ticks = sysconf(_SC_CLK_TCK);
> -
> -f = fopen("/proc/uptime", "r");
> -if (!f)
> -return;
> -
> -if (fscanf(f, "%lf", &uptime) != 1) {
> -fclose(f);
> -return;
> -}
> -fclose(f);
> +	char path[64];
> +	FILE *f;
> +	unsigned long long starttime;
> +	double uptime = 0.0;
> +	long clock_ticks = sysconf(_SC_CLK_TCK);
> +
> +	f = fopen("/proc/uptime", "r");
> +	if (!f)
> +		return;
>  

You are not starting with existing upstream source!
There is no code with /proc/uptime in upstream version of misc/ss.c

Also the point of ss is to print info about sockets, not to
be a replacement for ps.


