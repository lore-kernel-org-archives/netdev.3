Received: from smtpcmd04132.aruba.it (smtpcmd04132.aruba.it [62.149.158.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60DC4F0520
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613886; cv=none; b=ga5bA0vVzEMFw2u1BVgsprVgLmKB2bdSTcOeCFi3cl0EtcE5xTgXM7yAoZOMu7VqYplikhjv+hccHEvcQdRJFJ7ELJIgNa9L/HxQyd+sNqeIa/468caMgnCuK1YtB+BBPMCn01hIIO62lnERC5XrAkBGSTjeFNVEhrH2AdCox5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613886; c=relaxed/simple;
	bh=4Ebey87VEC2Sy1nN53gKuST7JmuOLoWCUaBl76N3ojQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lm79voNivOztij3skciYEqNO2019Qw+btI6LDe9pZVvQK9KeTkdY0yr6jO3NFiu6yhmy3LI5EdicBRhidZB5absfUKbKnhACtNdmAFcQPg9Xp+Pp3WPdOtqL6U5gDGLELzXYNsAGCS9lg31k8OqcV1MMKRVbvQF9RQdP6e4nSnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=np0LPM/W; arc=none smtp.client-ip=62.149.158.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="np0LPM/W"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id BEPxxBNV9rqLfBEQ3x8lsz; Mon, 28 Sep 2026 18:41:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790613696; bh=4Ebey87VEC2Sy1nN53gKuST7JmuOLoWCUaBl76N3ojQ=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=np0LPM/WkDSAtEezav8whPFdLtieMzaMNWxe5XDIuy59/zMxjf1uXmsx76jBHZyIU
	 XASgZr715wy2wcTprjK+sJdaoVNLgQOJr08PVdKTkoh27NU09ZAhlPDz7bPsuxSSRB
	 Sqgl6ZnFdpw3TfJdsnmRot61ARFJFYMamJADGYp2hilVbC0HEVBe7h3KpdbxgDiRDh
	 ZQW30gJsDM4HGGHd0HKbjD1WRCAxMss7vDN0TSZKWURqRXPk1uZW2eNdTb49f4sH97
	 Y/kF1wDx8WE/CRiRGNbmYNrPG32X23/bMzvzuaBcqkcYJgHwjstA627jbIFGGMC+cu
	 U52zIX3PFjKUg==
Message-ID: <7098f5d2-043d-464a-82d9-a105e4000c02@enneenne.com>
Date: Mon, 28 Sep 2026 18:41:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] pps: Drop the !NO_HZ_COMMON dependency from
 NTP_PPS
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260829210041.40649-1-dwmw2@infradead.org>
 <20260829210041.40649-3-dwmw2@infradead.org>
 <f6e90a49-8c68-42e6-bdff-ea9b3ecbaf7b@enneenne.com>
 <fc1ec38dbc3723f7aed73ebf3413e1d81c161228.camel@infradead.org>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <fc1ec38dbc3723f7aed73ebf3413e1d81c161228.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNDYwTfEqsC4GpI7TTFi+oSbTqe4C5mywxys7oqOfGTrjX6ZCyz7VeIGc99bxfoRmuc8ytCjWSYrAUsRAofSoZyce/2/oZ7C8orHAsynP5Bh9mv5GMvh
 DRDonXZsshHRO4ghgdRBZzzcRVFsNx5QCpCNFsjXteFdhAte+QsaxqkKa+AZKJo+JGJwP4aeNAHwjCIWbBEV6CKAf13Av5tIn0DMiyfJWR/2t3j6saUaQLqn
 xwujUylWjHyS98D1+TxF/eV7fxrP2hfwKw7rev0mQxOXHHmDxWRlMqCGOW3ZgyfmJjpy011IC9Sr6KTFcdjTVmK1XQYZ9sbHo+9CCG6/CeNJKRw9pgtJ71kZ
 IWRT26u1wkUFDlxyZK2T38rbXrbjiI6UlbH/eP0xK2E6HDm6Ua+KVSSo8i/hExgjdOFXZZWuhtC/jd0KjwlrTudarVInilJt3l09+LyIDMt9BRTTHDiNajCS
 qxmMkym16Atzvtym3u9NiG8oW0cKb67hyQEMuFc9s7F26GIwbyQIZ4DJ1f6g2mApnZ0ZNp2klXeYZR7FDIaHBsfSlsIYTQmAFV0bFu2v2mmw7BREIMrX/POt
 83G5UwDbE5DfdeHq9cBUqSGD

On Mon, 2026-09-28 at 14:37 +0100, David Woodhouse wrote:
> But I can *simulate* it, by running a virtual machine with vmclock and
> knowing the precise relationship of counter to real time that I'm
> *telling* it to discipline against — then checking how it did. Your "no
> independent reference anywhere" is my "I'm actually testing the part I
> want to test" :)

What it cannot show is the thing this patch actually enables: hardpps
on a tickless kernel driven by a real PPS source, with its jitter, its
IRQ latency, and the CPU going idle between pulses. If you (or someone
on Cc) can run it for a while with a GPS PPS on a GPIO and report how
the offset converges compared with a tickful kernel, that is the test
I would like to see mentioned in the commit message. If not, please at
least state there that the validation was done with the simulated 4/4
pulse only.

Ciao,

Rodolfo
