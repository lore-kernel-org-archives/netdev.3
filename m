Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC70A4AA598;
	Thu, 24 Sep 2026 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276928; cv=none; b=nis2y1nWpTCU20BPaMXJDfnRcRrTuEpaBaK6LLnALmDN4jW4XtK15k/aPJyO/D3ZAKnbZWRn9Fmlb7gvy/4h7hIEUWQszR2fTuFzQkEQGLK/QQyg6ufiCx46ekw3caA0Q8oNZmKX5pssB4m2Bch94Gf8ChymA7d2kv6QUj/66jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276928; c=relaxed/simple;
	bh=AOVJWrn/3pT5+4vKYMK6tP+vxISvhubgl1S77xWj61U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZT+xTswyXebSMkddDn/RcG7GepnZPQLronLdyhH3bnI8ATsrtM+mq7ch4o+5f0wrH/3IzXnM4amGSlPonLewxJK0QOB1625OyfkPrAS3+rURjl6eVz5heyCmmwRIUi6ca3hoCH/qA2Jg0IcgIdXacK7jbr2EFxCUOPKEbHDkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QeVYSCXO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QeVYSCXO"
Received: from mac.lan (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id CA81C20B7167;
	Thu, 24 Sep 2026 12:07:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA81C20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790276877;
	bh=2NffPDVf8N2c+famrfJuH1xIael9/jEVCLfR+iVeOPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QeVYSCXO4EZdb5E8t+K7+nvcGwGYxyUERd5esOFQkSpdmvq5W19+68v6Kj0Q6Arrp
	 UimkSu6CAv9wA0UYOk74BBkjnH+kq4wySOHjcj6JAW3RHs5hdNIQahbN06hwTZD/tj
	 4EiCOoaNefEUmeDpLKovqdSsvUxTMQ3UXdDSOVSE=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: omar@blockcast.net
Cc: AutonomousCodeSecurity@microsoft.com,
	andrew+netdev@lunn.ch,
	ap420073@gmail.com,
	cenzhang@linux.microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu
Subject: Re: [PATCH net v2] amt: do not store tunnel pointer in skb control block
Date: Thu, 24 Sep 2026 15:08:29 -0400
Message-ID: <20260924190829.34651-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923225630.95537-2-omar@blockcast.net>
References: <20260923225630.95537-2-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Omar,

On Thu, Sep 24, 2026 at 01:56:31AM +0300, Omar Ramadan wrote:
> Agreed on the refcount. Could we avoid both the refcount and the
> lookup by not sending the relay's GQ through amt_dev_xmit() at all?

Thanks for the exploration and the thoughtful solution. I did not
consider removing the round trip in the first place, since that
looked like a user-visible behaviour change, but your write-up
covers it well.

> I haven't reproduced the KASAN report. Could you share the netem
> setup you used, so I can run it before and after?

I will send you and Taehee the reproducer artifact in private soon.
It covers the base, base + your diff and base + v2.

> If you and Taehee like this direction, either of these works for me:
>  - I post it as v3 with your KASAN trace in the commit message,
>    keeping the existing Reported-by tags (you're already one), plus
>    Co-developed-by if you'd like; that needs your Signed-off-by.

If Taehee is fine with it, let's go with your v3. I am fine with the
credit as long as the CVE credits the report to Xiang and I (so for
my institution).

Thanks,
Cen
