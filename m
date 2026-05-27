Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9523655ED
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909151; cv=none; b=M1dSb623Ju+79yrdOfXrDiySMKpD9eWMfHcW432Mm0VKCstx/4Mbpd8ltQt4BKcER9PTKY7OmqKPMV8e1eCI6owTW8PeI3755TI9DUcROb9jEaB00X6SDCvYMFNz5szNpCqcHkWFMJ7keco/n/bANLnM7sElFisCDYIDiRypHXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909151; c=relaxed/simple;
	bh=/qWL3dEkI4d19xvrt6zgckl3ApyLkUpqBs5z862LAVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPpd8MyuXJ8XIzVuNFOXWIW07raCEsSKuFgU9ZyLqgEl61NGGX1vB9Xi5GxtsW7/7/+QKY7zXmxDQFzRBri1XCvxgfPjnyoUb8RDbN4E1Tr2a8/xV9132lGiroiiC8/mp0K31Af5AgZ3zAw472BESnvk9079Ml9bLpxB+UopPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID9vtxiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID9vtxiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310091F000E9;
	Wed, 27 May 2026 19:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779909148;
	bh=luhqPyQnMA2b4rGP1flUj9cp1S2jy4YVsh9jrLcTSg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ID9vtxiIW7mAdSg3etwxHR3zfpT/MUg/L7u3vmMkLo+R1MS5xETTaes0HyUsIRp7/
	 SUV18bCVAIfZLSWT8yXKk9r+p/iGy2h+SnmjC3CUefKIX+qc67cqodpmiselfEcF+E
	 053kT4HTMoKTxPF7T4gK/GTSVqaBt92xEIUZTCqJKyikGJ8H0kgRNMZpyaP8KmIRsu
	 iBEnz+xFn03ELD9lFPLv/dGrGU/mCKG5xCZXWrQDjT/7PimYY5LKtAn/3D99HdBX15
	 i9nzxO6gQcLD8v5oPKOkxFO5KA2mezdxAbXorCDzCbs6cFRwRicWvv97A9ueX8L2/N
	 IJiwLZN9fjsrA==
Date: Wed, 27 May 2026 12:12:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, Chintan
 Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>, Daolin Qiu
 <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Felix Maurer <fmaurer@redhat.com>, Neelima
 Muralidharan <neelima@ti.com>, Paolo Abeni <pabeni@redhat.com>, Praneeth
 Bajjuri <praneeth@ti.com>, Pratheesh Gangadhar TK <pratheesh@ti.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman
 <horms@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v5 8/8] selftests: hsr: Add test for the inline
 PTP header on HSR
Message-ID: <20260527121227.40bf085c@kernel.org>
In-Reply-To: <20260527-hsr_ptp-v5-8-158a7633eac0@linutronix.de>
References: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
	<20260527-hsr_ptp-v5-8-158a7633eac0@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 17:08:58 +0200 Sebastian Andrzej Siewior wrote:
> Requested-by: Felix Maurer <fmaurer@redhat.com>

Please don't invent tags? If you want to say that Felix asked for this
just say it in English.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  tools/testing/selftests/net/hsr/.gitignore     |   1 +
>  tools/testing/selftests/net/hsr/Makefile       |   3 +
>  tools/testing/selftests/net/hsr/hsr_ptp.sh     | 109 ++++++
>  tools/testing/selftests/net/hsr/hsr_ptp_test.c | 438 +++++++++++++++++++++++++
>  4 files changed, 551 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/hsr/.gitignore b/tools/testing/selftests/net/hsr/.gitignore
> new file mode 100644
> index 0000000000000..849eecb84c974
> --- /dev/null
> +++ b/tools/testing/selftests/net/hsr/.gitignore
> @@ -0,0 +1 @@
> +hsr_ptp_test
> diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selftests/net/hsr/Makefile
> index 31fb9326cf533..ec11fee56d8f8 100644
> --- a/tools/testing/selftests/net/hsr/Makefile
> +++ b/tools/testing/selftests/net/hsr/Makefile
> @@ -7,8 +7,11 @@ TEST_PROGS := \
>  	hsr_redbox.sh \
>  	link_faults.sh \
>  	prp_ping.sh \
> +	hsr_ptp.sh \
>  # end of TEST_PROGS
>  
>  TEST_FILES += hsr_common.sh
>  
> +TEST_GEN_PROGS := hsr_ptp_test

TEST_GET_FILES otherwise kselftest thinks its a test and tries to run
it (which of course fails on

+	if (!slaveA || !slaveB || !hsr_dev) {
+		fprintf(stderr, "Missing network devices\n");
+		exit(EXIT_FAILURE);
+	}

given there are no arguments passed in)
