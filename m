Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9C22CCB9
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933093; cv=none; b=MNxqwql/Ek6y/e9ailvel9Olt1SOVCXt4AtvF24Ml9hum7c71eRAkHjzy9SHXxWkaYeHe3oo/SRDjuYlZgCXW3WqCMWI2O0UdSLtuyiy66UNj7Awv58o8iNLjMVhiWP6tt3wsafp2Z6nE9rKYRHwwjbdKjAZqoODgVFQ/SUZeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933093; c=relaxed/simple;
	bh=TdE3I1D7GAfpzTiSKx8PIfRHrfbRkoBda005vsXhHLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpTypzGX/OE06sq3NXfYMwugpKPijbTPLjuhnfNomLvh4ov9gdEjtiTQ4HSsbGhDTyyg0gdu4rcUADsZcfchkQyoytzMMF4r7xCZ2xwliUXW4eVcCDXQRmBYtpfA2PxujoLFXRPpOW5jWc7xvh7vkj7bUBf/X2K4yMaBPRwm+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=HQPPp1ys; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="HQPPp1ys"
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 893B43FE5E
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 16:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787933083;
	bh=BdiRN85AGVfqT2duX9hv72UQ7MsPQaQ1CfhUNZAX7ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=HQPPp1yspowci4Z2SBCSxeBmRRR9tv2WgQJrfL7XzABVffDJoDutUPduHHsUnJkZH
	 GWOkQ3eaXEg+jaDHVuhp1T/gqdFgB7vdu3EdO6tjvAXWteRikJYdDxNZcEHYN/H7lr
	 nCxVGXKlhMdLZXg1mi3tDOWCBlzWP6jMuWpRwiwYs+ZEVHT2FefbVM4CQbkn5r6jwD
	 yAclWwwMmHCesqPbO48PbSzMqM7WG5AHpTCbHgQOQnhZpWUxZz0YimZdkwohfGq5gj
	 rXNj2XaiEmqPl4iMgDxwhvmKzvmY6f6eezqHNd25IhPg3slKk15ihcyWU/XLxhCHO9
	 ZRvf8ul18rVAc/OwZpuv7ohLn4qMTom+jv1SSZ2P1Nnpv0pLB9l4MOnftWM+Rkbn2V
	 HXqjrdkvgQkg/iQzXqd56ocFZ9eb4H8Qn8f+ejuORqZVicE67Irl+zZYtyFZ9sq8ri
	 YA9pXP7S5pOMRVcRifOC6OfTHPiGGDJSMRQCGLLwZvBnzg6N9gl4LuyRq2zYiSKZA8
	 hrETGxvi5RQOBVXlTAEWktmJo3foLtGIjQScp4PaAdN6a9JxfA4KvH5VmxjKOlpE74
	 fGs09Ula9t1Ie4F2phzVhRGeOEomq0C+I7M9Zh4SfGYEICZZXDQ1nk7VjB0Gl1hUPy
	 vzFdqk2cP75noUjswXLhufxw=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso5491515e9.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 09:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787933083; x=1788537883;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BdiRN85AGVfqT2duX9hv72UQ7MsPQaQ1CfhUNZAX7ig=;
        b=rK2AmWdUNfYNyoWpow34/lFbTuNkH1OSudWKK9q0zpkIgRVy6P+HQTRKnAvsNzqivG
         wSn2QxBqcPQU2GGLGpG+HgBHK6ZtJyGRpvMuZfJxx2x+PQ/g5YM8wgezNHDSUT2EVuqC
         81KzgZ59WjnmSTyl1frKpNPlfD9XffR0UJlMHTYQTOU7TazncKz8lcGKGIUkzolEHzRg
         mD0pELnb6wuMCEAFezPKkPqg/UloBNaMgyihc+a0n1vYeD9NCLhTjM6s9s34BGk9u2Ux
         KiHce/6FDgxsv1tIE28o+2MJODwnaHhgfB3LrxsSCdCw7NCEkARynUOeQM0MGrIO198k
         vRJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqO/I3zDeHUpc69TDNA+sBCKT0TyeN0KSGLimyktwWoXCvfhPl4jAs3AzRKlHfdkuaMfg1AFMA=@vger.kernel.org
X-Gm-Message-State: AFuF++kKmshe1T79b7ulqU8OOqom1wx838jZFFp8zoE2MIESZR9+Y2lE
	7Jaj6O21VlVeWKAwNy82jdf0Qr4j21zOJ+MP+OqQqofjH41dAZHsU2XCGvCUwEqFMSQp2UTikXS
	6mfymisvrEMb8Wpm5Ch3rP1Foo4ZoOrsNxqbzKKkV1qa1pH8m+VPLyekWelHk2qVBiCHL2MgbQA
	==
X-Gm-Gg: AR+sD10H33bEw793prfdrZbztOhBB4bjygsYyc28OzOpo5c7rkuf2K5GK+xYhzVZxEr
	zKWf0PiCTBFT19g4/HmoVyT96fQmcw8SBcDEMMFnMFYxsPr9jMDpYZtQvtY9GiOyUj3tT73GC+3
	WDlUjk99HVYg6R0vbBNmnqi/VmCONjHDEj0ikWWO2TlLsO3jTrw0Sbp3THmQQ/nmZkWAvO9wgAe
	0x7mZmWyfJRHWIW0aaIv12ZU/es3o0IZ1JKCsdoHdqPGjq3gq8YNiDXAauUHaBtTboF1eoaVa8A
	fFgdA7QgS4lUsqHdFyiGiW+rLTZ5MFdylJH+HK23JVXbptoewjF+2fZIjuMYOve4CjPKSt4pFFV
	7zuqafDjayUT5IwMWVriKpuJqN+0rTueD2uJfigwAOHzYzTHHzl4UPfHmp68ktDEVHUlrmA==
X-Received: by 2002:a05:600c:620e:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-49cc0d4545emr47903925e9.14.1787933083086;
        Fri, 28 Aug 2026 09:04:43 -0700 (PDT)
X-Received: by 2002:a05:600c:620e:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-49cc0d4545emr47902965e9.14.1787933082708;
        Fri, 28 Aug 2026 09:04:42 -0700 (PDT)
Received: from localhost (93-35-113-52.ip54.fastwebnet.it. [93.35.113.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dd2517sm62531535e9.7.2026.08.28.09.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 09:04:42 -0700 (PDT)
Date: Fri, 28 Aug 2026 18:04:41 +0200
From: Alessio Faina <alessio.faina@canonical.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, hangbin.liu@linux.dev,
	stefano.salsano@uniroma2.it
Subject: Re: [PATCH net] selftest/net: skip srv6_end_d[t/x][4/6]_*_test.sh if
 iproute2 too old
Message-ID: <apGxmfjQs247lHX-@cicciput>
References: <20260824091537.2305107-1-alessio.faina@canonical.com>
 <20260826000156.bdaa71db68dbdc9c13907205@uniroma2.it>
 <ao7S04LkWVXAQpgq@cicciput>
 <20260827030701.bfaf6eea6dea1aef24c353cf@uniroma2.it>
 <apAJuZzDOvjkVx60@cicciput>
 <20260828042357.1d6e802448752a8fdff5a485@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828042357.1d6e802448752a8fdff5a485@uniroma2.it>

On Fri, Aug 28, 2026 at 04:23:57AM +0200, Andrea Mayer wrote:
> On Thu, 27 Aug 2026 11:56:09 +0200
> Alessio Faina <alessio.faina@canonical.com> wrote:
> 
> > [snip]
> > 
> > For the DX tests I was doing a local test but it's not in the original
> > kernel, sorry, I must have confused 2 tasks with one, so disregard the
> > DX4 and DX6 tests, they are not relevant to this issue; if we manage to
> > agree on a solution for the DT4 and DT6 tests, I will discard those
> > modification in a subsequent patch.
> 
> Ok, so this is about the dt4 and dt6 tests only.
> 
> > About the DT4 and DT6 tests, I thought to use the same method as the failure
> > was practically the same as End.DT46.
> > This is the version I'm currently using 
> > ip utility, iproute2-ss200127 (should be 5.5.0 if I'm not mistaken)
> > and I can confirm 
> > [SEG6_LOCAL_ACTION_END_DT4]		= "End.DT4"
> > [SEG6_LOCAL_ACTION_END_DT6]		= "End.DT6",
> > is available.
> > 
> > What do you suggest would be the right way forward to check what is
> > going on?
> 
> These tests need the vrftable attribute. The help does not list it
> before v5.14.0, while ip parses it from v5.11.0, so a help check skips
> tests that would run on v5.11.0, v5.12.0 and v5.13.0.
> One possible way could be to try the route add in a throwaway netns and
> skip the selftest if that fails. test_encap_lookup_supp_or_ksft_skip() in
> srv6_encap_lookup_l3vpn_test.sh could provide the general idea, but here
> the netns also needs the vrf device and the strict mode the test sets up.
> 
> That's more code than a help check, but it skips when the route really
> cannot be installed. There is a trade-off to consider, and comments or
> other ideas are very welcome.
> 
> Ciao,
> Andrea

Hi andrea,

I tried multiple methods:
the first approach is yours, but I can see the following error with any iproute2 
version I'm using (I tried 5.5 to 5.18): when running 
"ip -netns ${rtdst_name}" command, it always returns 

RTNETLINK answers: File exists
2

I tried the following approach as well,

 	# set the decap route for decapsulating packets which arrive from
 	# the rtdst router and destined to the hsdst host.
-	ip -netns ${rtdst_name} -6 route add ${vpn_sid}/128 table ${LOCALSID_TABLE_ID} \
-		encap seg6local action End.DT4 vrftable ${tid} dev vrf-${tid}
+	if ! ip -netns ${rtdst_name} -6 route add ${vpn_sid}/128 table ${LOCALSID_TABLE_ID} \
+			encap seg6local action End.DT4 vrftable ${tid} dev vrf-${tid} 2>/dev/null; then
+		echo "SKIP: SRv6 End.DT4 vrftable not supported in iproute2"
+		cleanup
+		exit "${ksft_skip}"
+	fi

where the test is checked at vrftable creation time, and it would
cleanup and exit as expected from standard tests.

But obviously this gets the same RTNETLINK answer as an error.

Then another approach came to my mind, and it seems to be quite reliable.
Practically checking if the ip command contains the string "vrftable"
using the "strings" command, and if not, skip the test.

Something like this:

+test_iproute2_vrftable_supp_or_ksft_skip()
+{
+	if ! strings $(command -v ip) | grep -q "vrftable"; then
+		echo "SKIP: SRv6 End.DT4 vrftable not supported in iproute2"
+		exit "${ksft_skip}"
+	fi
+}
+

What do you think about it?

Kind regards,

    -Alessio Faina
