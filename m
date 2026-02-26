Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AAB37FF6F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772107539; cv=none; b=ZGik03ehv0U3Jw8X8yQLZ1m87HayENIsdwkfhpfX7fx6mt2fX+DIMY7qArltIHMBlPkChg5h8Nb3ygOAMJZ6KM6rUy2BXl6NnYdXj/sGOlZl7cSXzBW71LSq2hd996qH2W2k7TPlKAW1h4R4QXAUNqOl9oxqToxrmA4cSuQ6WQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772107539; c=relaxed/simple;
	bh=A5dFRRCQjsWGVb/MvbVCVM8MvJA8LbLiMMWYqv5yflI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CArkhfpB1rUbraGrVYUKVhNEDXMgtmjjAOwt5diihsuEP/rmJJwGWhZqA6obS6M38RGqr0DQJEhkPpQlr8JmTzmVADjiGnEwbLJnPNaJ7k1YDN2oy7rupvyHRdhm3qgOvy/02/MT7fwElNDtSiKwFVqKEHG2NJUXvrRR1KfvMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=IvwH9DoY; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="IvwH9DoY"
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1772107536; bh=A5dFRRCQjsWGVb/MvbVCVM8MvJA8LbLiMMWYqv5yflI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IvwH9DoYYdKF9J3FjEqQYkV0sYW5LehRJLHm0OiCL1eD7GVONSeuD5gFqh2i0vJmB
	 SXW6JR18hvKxfylkfzmI0QPk2nfUZc7Q+5LODGL6GhvylxM9GhJgjG1Ytn/+cf73PI
	 rjRIz8JiRmpaC0sXDIn3HcV2rpRoJ/6ce+yHLNyzbIOMhA2zujWwGkJOsU86KxY/WT
	 t3FEKfa3N4inQTMQNkeSDitg3c9cfXHzcoeCbZDTahEKHeVZFjCO8oET3ib//GBl8+
	 leLnBCqMoGx/xkip7MYZlTmlNDZ1Ohipj7IvtPE83rbH8V5F/5lXzn9NGWlU7Q1yB9
	 +Vx+bw8qBhuKg==
To: Jonas =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, Jamal Hadi
 Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Cc: cake@lists.bufferbloat.net, netdev@vger.kernel.org, Jonas =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>
Subject: Re: [PATCH net 2/2] net/sched: sch_cake: fixup cake_mq rate
 adjustment for diffserv config
In-Reply-To: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-2-01830bb4db87@tu-berlin.de>
References: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-0-01830bb4db87@tu-berlin.de>
 <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-2-01830bb4db87@tu-berlin.de>
Date: Thu, 26 Feb 2026 13:05:36 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87seanlnfz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de> writes:

> cake_mq's rate adjustment during the sync periods did not adjust the
> rates for every tin in a diffserv config. This lead to inconsistencies
> of rates between the tins. Fix this by setting the rates for all tins
> during synchronization.
>
> Fixes: 1bddd758bac2 ("net/sched: sch_cake: share shaper state across sub-=
instances of cake_mq")
> Signed-off-by: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
