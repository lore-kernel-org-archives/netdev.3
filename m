Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2C3EB102
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674411; cv=none; b=hdq4fN96seTuSFNpqc0vJIWDHG0fE2m+FKzkn6KAjyz8xHHg1b5RsTUfN3g4HCvOASQ+MYVjNVRZsgcsJdFjE8APc68TifAF5ZdDFPk1FmD48ilXpTmfgmtt9xThrqobWn028N8xzySXBTiuMhMRc5V+bxQTIxcKvuCrLLSbjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674411; c=relaxed/simple;
	bh=2omY4jeKD45QAs6c4Uzrpdbso1L1zbSpSPWfvVOnlms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjFy8Q3Gcuvtu+SJ56Q/Mc3n+7+yIJFubNc2SDecIpJCKMIkw1q4Cau28ZYcyBHODKz0o7fKb9LTE7D9F4MWvraxWWUmnLbfsEOHMQswtuHO2XVHfwTVhrWQZFUttl5eMU/dj5oINWXNon/aXB1kSPcINW+n863mBvjvy/D74ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=OAaYAOtM; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="OAaYAOtM"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso1063722a12.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789674409; x=1790279209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z3I8ptWBRSM3AF+nqm1OQaQNE6zEemU6hdNRW0sNcpA=;
        b=OAaYAOtMLcU7ZFWf6/CbSZywngQR9Lrw71mp3/h24qQGDXlTzuWd1w48wy71MAKA3Q
         nCUl56Bq3bgrTujtpTj8ibNekCHMCQ4t4+yLgA3iUXUtVH06zHzcxMnzIAOThWt0XhPs
         oJJ6a+H3bss0olhdCEeE1hTaok3WlYtx7cXPH4gfhuILdSCtBKYE/2zGEV+VYzj6MVex
         0FdZM/zYqxoz+HbIeXPfEBd7GQxpJ16jgvbuCDp2gVRRDI0/7MxbjqnlDREhe36vczA7
         8mhLuMPE/xWJZIPwZTqXPaM4XsKnM4/h9zcNz2UkzoUY8llGRDUnmJa5IH7juOV014Hw
         C7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789674409; x=1790279209;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3I8ptWBRSM3AF+nqm1OQaQNE6zEemU6hdNRW0sNcpA=;
        b=CI1vAX9H2vtX1NidtzKdynaIkdwvX6l+1wZIeRjWlpSDCBD8arYaCuDTyxEJw/E2sR
         ZVm8gBbbL8RtTaEmVTaEEsfvGVokY5AczDyufDmzWD8xGRa628XhTRGzUIKbn95CKs7E
         9EUPjO6l9kQivlEfSdzok29rEb9uINWiQuEJsMC+1wGzX6SN3pdfGT/14bZAXnWXa3ey
         ArLYn3RkD67T6krRxgTPfFUiDtZ2pMFH3I5c+ePCXFvHUmxLefHVfwsyuCCvtkVreyab
         Q01AaP63zt2t9H8xI4uSBn50D1SVMTjeUppu+mfsMgO+tkvVjy8OYXCR6hXT/8V94jhN
         77Ow==
X-Gm-Message-State: AFuF++m2KqubiEplok1GUcAkWUem38sSo8Gm3i8jz7bLUvyE+YDYqRL2
	9SYYD5O1tfsDbK0aZJb068F1RP3xzQNhMax7AWGRtPZlKFkOF5qlEj/glYJhV4gXfXs=
X-Gm-Gg: AYBFou0mE04f8zhU4oVwbQEQIBQwE6XxC5wz2DFrNXnZjT62qfW7SIlIr8L5rjt9vEb
	DhZy3QJC8j0h393YuGw0fTjg0kJ6WRNI/ZLxdrxVr4f6FTW4yHlUgJevgt442DZjtGNE2Rd8ynA
	OhxE+wEXZfD7/CtKi13FPUtviIXRvEhToMJAuxmK6Speq5n1JDInJB+ls3o7uOJDwAL1CgWfBjT
	b4FR/0wtbBOn0Xdj/TW1QBIuqVCSU3mRSA7oahDhmWKRMrXltgD/judJ2K00K4X2NyptCHtViPM
	4Fq2W7K1vtXK9thVZgfF5POAMy4aMoinDsGE0vIQ5Nyrym+PkvJa2JI+yYmNAYZTZQrUxoEsDj+
	dIgScO32a+xFaZzd9DgVpUwuWJMJsx54+ebwn0e4qdjPARapW1IOVHxN4kLhshUKW37pBbsxiZx
	o+G/5a6coiadT7vowes3dKnzTX5wmMxMk/7SEtueW3peu2yScpWOAzI86Fgm7klmU1ONW71olab
	8dgTTtkiCXoo/m+Kb7y5LxFczbU4/z5ZOWXUD5Q
X-Received: by 2002:a17:90b:2d0b:b0:39e:4c7e:f044 with SMTP id 98e67ed59e1d1-39e54fd5f69mr405359a91.33.1789674409281;
        Thu, 17 Sep 2026 12:46:49 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55ed815bsm41062a91.3.2026.09.17.12.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 12:46:48 -0700 (PDT)
Date: Thu, 17 Sep 2026 12:46:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Harshith Hari <harshithhari000111@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 v2] ss: add -P/--process-age option to display
 process runtime
Message-ID: <20260917124646.4c39c0c5@phoenix.local>
In-Reply-To: <20260916213402.8481-1-harshithhari000111@gmail.com>
References: <20260916213402.8481-1-harshithhari000111@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 03:04:02 +0530
Harshith Hari <harshithhari000111@gmail.com> wrote:

> Add a new option (-P/--process-age) to display process uptime/age
> alongside process info inside socket user context output.
> 
> Signed-off-by: Harshith Hari <harshithhari000111@gmail.com>
> ---
> v2:
>  - Fixed patch whitespace and tab formatting.
> Signed-off-by: Harshith Hari <harshithhari000111@gmail.com>
> ---
>  man/man8/ss.8 |   3 +
>  misc/ss.c     | 662 +++++++++++++++++++++++++++++---------------------
>  2 files changed, 385 insertions(+), 280 deletions(-)
> 
> diff --git a/man/man8/ss.8 b/man/man8/ss.8
> index b0629b82..5f345c21 100644
> --- a/man/man8/ss.8
> +++ b/man/man8/ss.8
> @@ -163,6 +163,9 @@ the number of packets dropped before they are de-multiplexed into the socket
>  .TP
>  \.B \-P, \-\-process\-age
>  Show process age/runtime alongside process socket information.
> +.TP
> +\.B \-P, \-\-process\-age
> +Show process age/runtime alongside process socket information.
>  Show processes using sockets.
>  .TP
>  .B \-T, \-\-threads
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
> +	

I don't think you understand how to submit patches.
This is repeated version where the diff is against your misformatted previous version.

And you did not listen to my feedback that the ss tool is about sockets
not processes. If you wanted to this kind of thing better off doing
some local tool that either scripts ss and ps output, or uses kernel API's

Don't need more growth in tools for this.
