Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030D6480965
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862227; cv=pass; b=uh5vo2XlY2uQkSX0cPNgGAK670qiC4zQwUhXVyFI9i/5KQ5kZB8wtmWigLFx/U4xDtj/sAXX/d8XCv4VkSLbFEH7SnQRKLFyswQWYaVxg8Cc8DnG56GIN4dYJXKBpOwSTFdoxcgjal/ZPhI4jG04vU6Q5aMauUmA5JdG7FAW7Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862227; c=relaxed/simple;
	bh=tuanMOupDYAV+JqOtUwVlLQmntJtBt1U3N0HaQ3Aw5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDN62URWvtc5UivhGy3cR+8L9V6TwW5Fkt5AkRaZnZ2F+IM3b63SRhbj28zToO3/uW+raHw6oUMGPN13eTX6PopNHbHUMmlZROQPHKgVMcpbNY/Lj2+FEBz6qvVrNaZKKCrWjsCS1A1B4dYiATATHhXptUUUW9BwSSedzfq87oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuahdNWw; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuahdNWw"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca88130e09aso3537814a12.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 09:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785862206; cv=none;
        d=google.com; s=arc-20260327;
        b=kV0xIu5Stn+wXzP+96DmS/VqH/bc5wrBUieBX/3IFzzR8mQs4MnVUWJoRfJwhjX97p
         wlfUQWjNJuqD8vIJLjJNApT57SzKxsjDdrSqs8NqmsE3WA8PifuBW6e843RjUbxl26e+
         hIT1s2V33FmLCBnVwRVjldMWgg8ytgcXdl2tahgKK3PdWFwC9OCqIxxb73z6HdhPsuZY
         MDvRFWaMQ8QhJbQ2l9Qzb+WqesaSw3vnHX8G9Ex4ocuoLalQLCHwXGctyUP90RWhPIoE
         vq5PEshbPlE7v9KaAHQ0SCg76aUBM2Fjq04iM7JgDqm+8MB6yr4nzq2OBhwXHM0pG3bw
         4EMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tuanMOupDYAV+JqOtUwVlLQmntJtBt1U3N0HaQ3Aw5I=;
        fh=CMOEUrQsfeOYOGJXm9h1TxWKLwbsrgM0Tds+71dZhfk=;
        b=KOQADqChZnwUGh5lXI45gxYF5w6F3/eVhX/X1zIYypvL8yyWbJ6T1ryb1m3eqXXdp1
         LYKxj/jWIkGa1aGzwVMR1WWfAAYXptr9wKqI7xthD4VG6uHsHYgKoKcH9Uc/OjllRO2F
         GsIxhVXLilsmNdmeCAGEPzgLem6Fo3tHXLBTLEar9YU2D8LwXsMBq8GLgkPBJpLJ+dEg
         /uFSLOlUauDrsZ2xzm7SAyYT0R4Y4n5AWmH5ywYfMlaF7wC/Na6wRmz8X0c28fsn8C5/
         o1ApmhIivHGdqL+6pcNRinLdSFinuCv2Iv22w3W47kU994LWRcm2ebJ/M04k5QcH8fPZ
         16UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785862206; x=1786467006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tuanMOupDYAV+JqOtUwVlLQmntJtBt1U3N0HaQ3Aw5I=;
        b=BuahdNWwupVIZfb7zF7Dc++15mYkom2zG69fp+MXGRdCzuZyaPpWCeK2RSJdbxGq3J
         ze/L+gnKXaamm8it8a/8xWRhM1nE21GeIciYAPYPD9okkJJBuU02XfXO0zMyeRRVRV1B
         dGpn1J0RfdJwpl17EwKT+O4I6dnFlRjgrSvbfYp5OIpc91nVxcm1cpf8LhEV4PnARCjx
         /Hx13+frt0uZ642YEvh6467doCmXBABxhkIPEBJZQadzjck1C+i8tlXYtoCi9uQLnb8R
         afEcFuEq1DY4JcxJx1tL8cY+PFIfqpMHBW++OFFXItu8vSxsLLnAbW/iW7Mu67Fajw62
         KDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862206; x=1786467006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tuanMOupDYAV+JqOtUwVlLQmntJtBt1U3N0HaQ3Aw5I=;
        b=YHjujlzEgRYUXTFO0jKZ1RowoHcS6fnGf1s6n78bXQtrXUfXHuG09oxTqGvanXMSMU
         WGI/NbfwWbfycFhX/j4ibfS6uBoT2z2pNLgI+ZkrQl5A3bwyjvpvE6Pn9M5CRgF36EI8
         vUl6HxfTWF4ovbU84KB1hwgybMB7QgecSaj63Zk0BBJtT157YD7NNUFvPW1Er3FbGAkF
         Y5DJzyDhGed8zgQ4J8O6UdHx5gyAFt+MwOFIbhbO7/d8q7mdLXdYYnHscKfZZfTSZhaj
         ji38djo1yN2pi5PeQ4dfqIaNaCKZt7GHkpjUS1zSwkN9hNlgz3ixeS/btsFXqwsQ4aEA
         9Iqw==
X-Forwarded-Encrypted: i=1; AHgh+RpqL0YoSqZl/+VFGjkY3isvB+G8PKg/+J+SybQp3hNX0FXar/9ckfHEcUTGpAFP/qrRlCrnOTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu91NyugZG9iDPwmrCWqnmz1gAort7ofAtoTRgqdigEvT4Wdde
	vY6/J8HmaTr/nrnb5GDEzmwGISnEYx9114T/IFUXxUD7dDdTTaT6u88LpLVfxF/4KGNP/rHH+Gu
	JD0B9k/qSxaM+ODH44B3LhhcXrgeMOIPSEyQO8cnn
X-Gm-Gg: AR+sD13lyNPRNm1DTcONiVmO3dJtNYCSOocs3/uiu0Q3Frtmi09dMNGjpeKWPGylOvX
	EkrGOFELuqmoPZ1q1QSit+4f8o2mPKY02nWAU65qOqkWk9idzJcBxaw238fI1DtU6FpfCsRqBOl
	Hrx4XdWOEQE176fDpOIbw/fpieoSDKhSoZY97awEyLXWnvcywTIm9BVlv/Jg93/os38vZqebRf8
	/ALDcmHhnKkY6Zy5yWmhcszhl1wGo9m+SA7v5cOE68PukEpHIeUM+/oDwGyZJ+qwtlxvYtxBTu+
	7eh8Nz8boA996M1ugaBUg8exsODe9rhTkPfL2/o8agx/vxEylQvS9bi+tycmVwsQGUkVc/jbhfo
	/mBC5C0m03OBXXDjO95wiY+04az04pQ8rwigORjoggXx0L0pSDODlBUaKzGF81dL36xzKVIG8hG
	3R9kd7i1EEDUo26PS8ToHcRcU=
X-Received: by 2002:a05:6a21:3392:b0:3c3:9595:57ef with SMTP id
 adf61e73a8af0-3cb85ffd1cemr193900637.31.1785862205404; Tue, 04 Aug 2026
 09:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802151212.3294591-1-jkoolstra@xs4all.nl> <20260802151212.3294591-2-jkoolstra@xs4all.nl>
In-Reply-To: <20260802151212.3294591-2-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Aug 2026 09:49:52 -0700
X-Gm-Features: AUfX_myNnvBRmCYK55Ljjsutf2qL7MqRgERjXdZYx1md0JbPpsxmxzq8ks8CsOU
Message-ID: <CAAVpQUAW4eTfvNGaY+9gD06Jct6tgM3LRYdLEVFG+VzhCFYojw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/4] net: af_unix: enable custom setsockopt
 for all socket types
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 8:11=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl> =
wrote:
>
> unix_setsockopt() and the SOCK_CUSTOM_SOCKOPT flag were only wired up
> for SOCK_STREAM (introduced along with the stream-only SO_INQ).
> Consequently custom AF_UNIX options are unreachable on SOCK_DGRAM and
> SOCK_SEQPACKET: those setsockopt() calls bypass unix_setsockopt() and
> fall through to the generic sock_setsockopt(), failing with
> -ENOPROTOOPT.
>
> Set SOCK_CUSTOM_SOCKOPT for every AF_UNIX socket type in unix_create(), a=
nd
> also for accepted sockets in unix_accept() (reachable for stream and
> seqpacket).
>
> This is a prerequisite for making SO_RIGHTS_NOTRUNC settable on all AF_UN=
IX
> socket types.
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
