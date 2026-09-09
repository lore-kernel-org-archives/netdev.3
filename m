Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67383C2B95
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937333; cv=none; b=udyFs61/dwQevCTrIKQcCl4XrDc0secjoL58VoZm1WFDIYhZ4GvNqZnjObbIy8M1fryLno5F+98jKZ/niJcRnyIrb6uUfcDGd7c+2aMw0NrgX7U5ip9TosyXJTjNw42Fa9hjbudo/Pb377thK46vju0cwJ4G9bLNJj0d/8wSTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937333; c=relaxed/simple;
	bh=ZZv1akYJZj6gc0uxFoqDwG43FngE7gmc8NhDjalyGRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GylQ+W3ohNxtTWQPvDKHaWQY7jgP8I1xCRxVmh4oM9w4z5pfONTEdqpd9nHcrUF6hJK3KumCiNd4Gk5ns41jft1Cr3YJyaTvLqykajclAytLpcBZtMN8iobrmziyu7IhP74efdpQeMSmqV0btJVcBIzPqezLkdGqTxxvnf9bX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cRjvttb0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cRjvttb0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4E30A4E415A5;
	Wed,  9 Sep 2026 07:02:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1A1E460448;
	Wed,  9 Sep 2026 07:02:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EB9C11C7AF56;
	Wed,  9 Sep 2026 09:01:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788937322; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=P0lYhwcf2b72il8635ikEmGu2+KdzY3nczMPKcEPEF4=;
	b=cRjvttb0QP5NtUzg2yIQ1M54ncR/KUNWWq25rK4OJiejqqWd7hi8ncbcnLW6fbo85QyOhn
	u39kWaOf+msJqpSpKtlFLngfOXzXXSxa2r7T1OjHd6GrLSA6m6GeVq7blLqKiU8Cokj0QJ
	PU0lJ252KCUd6aRsuDP73po5R1K0UdmbnCzt5qeIxVHgm/Hs9PeK/iS+tu397ANNTaZJ/3
	zUuuIuuiSzau9mO7efwW6itFl3i0iCQzaBpjXha7/vYBKXr09fpZI89APBv4/p0n3x+Vv5
	EXcsRWQZ0+dcEI/K0bD4pbgPLDnRcvAUEs27ryfE4rbe6PIIASfwFW03CQW2CA==
Message-ID: <bdb11b67-60c4-4014-a38e-dbe4aa98cc53@bootlin.com>
Date: Wed, 9 Sep 2026 09:01:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] tools: ynl: Allow cross-compiling ynl and
 associated tools
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 matttbe@kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-kselftest@vger.kernel.org
References: <20260907161438.755125-1-maxime.chevallier@bootlin.com>
 <20260907161438.755125-2-maxime.chevallier@bootlin.com>
 <aqCyWQxqKDuQnZYR@devvm29614.prn0.facebook.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <aqCyWQxqKDuQnZYR@devvm29614.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/9/26 03:11, Bobby Eshleman wrote:
> On Mon, Sep 07, 2026 at 06:14:35PM +0200, Maxime Chevallier (Netdev Foundation) wrote:
>> The ynl tool and libraries may be built standalone or through the
>> drivers/net/hw selftest machinery. This may target a different arch, so
>> we need to take the CROSS_COMPILE variable into account for LLVM and
>> gcc.
>>
>> Let's include the tools/scripts/Makefile.include that deals with the
>> CC/AR resolution.
>>
>> Fixup the ynltool CFLAGS handling to use +=, so that we don't override
>> the ones set in Makefile.include.
>>
>> Makefile.include also sets the Q variable for verbose mode, so we can
>> drop it from the ynltool Makefile. This will allow properly selection
>> the verbosity of ynltool builds with the V=1 make flag.
>>
>> Reviewed-by: Matthieu Baerts (Netdev Foundation) <matttbe@kernel.org>
>> Signed-off-by: Maxime Chevallier (Netdev Foundation) <maxime.chevallier@bootlin.com>
> 
> Hey Maxime,
> 
> It seems that this patch may break some invocations of make:
> 
>   # make -C tools/net/ynl/ynltool O=/tmp/o1
>   make: Entering directory '/data/users/bobbyeshleman/linux-worktrees/review/tools/net/ynl/ynltool'
>   make: *** No rule to make target '/tmp/o1/json_writer.o', needed by '/tmp/o1/ynltool'.  Stop.
>   make: Leaving directory '/data/users/bobbyeshleman/linux-worktrees/review/tools/net/ynl/ynltool'
> 

Indeed, but looks like the command you're mentionning never worked as expected in the
first place, passing O=/tmp/xxx triggers the bug, but before the patch, O=/tmp/xxx
just does nothing, out-of-tree build just never worked for ynltool :

Before this patch :

$ make -C tools/net/ynl/ynltool O=/tmp/o1 V=1 
make: Entering directory '/home/mchevallier/work/netdev/linux/tools/net/ynl/ynltool'
	CC json_writer.o
	CC main.o
	CC page-pool.o
	CC qstats.o
	LINK ynltool
make: Leaving directory '/home/mchevallier/work/netdev/linux/tools/net/ynl/ynltool'
$ ls /tmp/o1/
$

The fix is simple though:

-%.o: %.c ../libynl.a
+$(OUTPUT)%.o: %.c ../libynl.a

I'll send the followup rightaway.

Side-note, out-of-tree build doesn't work for other ynl tools and utilities, but at least
trying to do so doesn't error-out.

Thanks for the report,

Maxime

