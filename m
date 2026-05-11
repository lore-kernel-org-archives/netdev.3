Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A98235AC3E
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541203; cv=none; b=cVU0ex7l/j7pCjbnTsUTZFhZ/0omIgTwgNWOmbnGFsx1NfW41qQNxPIB12E/qzK2VI/JCPObFOuccRdYNHjcqTCvP4JtE9JtGozS3LEe5O6zmFRnmeZMzHA2adlvbzMHNiL08W9vGPiIai7v4BG86kfmJll/qGjPz1oeUuzLAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541203; c=relaxed/simple;
	bh=eqDFIL3LHasiAUpc2StacM0GSiAdWYx9GeRQtsAuxvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EF11r4bQyLdIgGrKDFIpbUg7yhSFKq9ve5Qd6QuLGXNxaX7Kt8YZnu7+tfbFK2PldeD/hot3eWmQQh192XfabpMR5W1s1r6M9AVbHkHlg1WNu+pk7r+UfDNyDowy61BYkcJV1etF56U78tz97FIe+FG7L0z73zSUoWEow4e2ffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq9SfhzC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq9SfhzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CB6C2BCB0;
	Mon, 11 May 2026 23:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541202;
	bh=eqDFIL3LHasiAUpc2StacM0GSiAdWYx9GeRQtsAuxvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cq9SfhzC8w79S7qj6+7gcE7PAXBUMTCnAX2kgbah200Hcnfin/yV0Ez+5+PVFt/fq
	 F9dBBwenT/FeXalEqziUre6vq/YTwtaPkITlEGcv60a6Dje4J0zoha2okc9yiM/pNh
	 lzQd5WF6Ye7e5SnoqoB5CHIkLYMxx3IlNgiK7cTLsUo2ap4ZudtSR6MeV6svSdh/Eu
	 882su12ik9LDQd7AK9iRnBCCeJuO/ko5z78o1ONdVqFTdl1aDOibsgwRr94hse3F9V
	 7ReUp9J+bsHoAP1a9uMIkudlhoRtaaEwxNFJpJLO/b+v9L2qJVm+oVEiMkPWNyA3V0
	 QVXBpsAP1UlcQ==
Date: Mon, 11 May 2026 16:13:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xingwang Xiang <v3rdant.xiang@gmail.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, sd@queasysnail.net,
 davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mrpre@163.com
Subject: Re: [PATCH net v4 0/2] net/tls: fix UAF when TLS_RX is set on
 sockmap socket
Message-ID: <20260511161320.358cfaad@kernel.org>
In-Reply-To: <20260511155210.32926-1-v3rdant.xiang@gmail.com>
References: <20260511155210.32926-1-v3rdant.xiang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 00:52:07 +0900 Xingwang Xiang wrote:
> This series fixes a use-after-free triggered by configuring TLS RX on a
> socket that is already inserted into a sockmap (the reverse of the order
> that is already guarded against by tcp_bpf_check_ulp).

Just to check - how much of this code or the patch do you understand?
