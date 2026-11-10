Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343491;
	b=mAWRJmTUm9WPc4FNy5hXobHfoffGhx48dc+uZFKopDylF5f+en+Wm9pDY0u6ZxT42D23
	 HFDdPI2z9uLFvXCYhkZk/98+jfqn0ybNfX6F3SeRF0lHP73xTweiJe80O7LhW3RnocrW4
	 TqnsZYqBjLRafMIwN8Stq9ZSxGbDjBHGWqgJ7+IxTvmJQEZZ1mx4xPMp/erEycaI6NjpY
	 AJ1mBrgRA2wk1/aQiavQajHYhQZQljd+2/9YFJKIXNtCZpOhjrjvAUh/IGWHL1xzvjasu
	 NsD+Fkrnjb2BVLcxMTqfTOutQtO3mthB1Mpi/3YK2SFYJofZapgG915YG1o/MqkHHmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343491;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=9iGjQx46W2MXVrCn0wgOootEUnd2i1SnVfH6gaH4IH0=;
	b=icPDGAn6DSDgM5STPGbbBMCMSQsgCyG4usqgACS+22MkuGL+DG/9ZohbpfYeV/PC1n2k
	 bpiNugAwqOytqaGuuGzmPOiw85idzjnxz/NFcgaGISYyXNw38Uopiks4/SySGuayKOxI4
	 ceNr3XYm8uJ4t/jDKIkJedit7y2HW0JHJbaJhONHcTCd/nNg6J/fp5Iaaplg7VXKHyh8f
	 2Yf2BZ3hBWzI+upJz8yVem53jB4+e+/gtUVVO4i0VrSUhEj1IgnZ1HpxUNSll1+ty/hpI
	 lG2+b8Oy6dLCtdxFO8cIfhlKA4qX/uhdlpPznsOFrpE/Zo6xdm0QuJ8rN9XhlSF++DQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=machnikowski.net;
	spf=pass smtp.mailfrom=machnikowski.net;
	dkim=pass header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=AFoWXKKn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66049606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66049606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=machnikowski.net header.i=@machnikowski.net header.a=rsa-sha256 header.s=zoho header.b=AFoWXKKn
ARC-Seal: i=1; a=rsa-sha256; t=1794343477; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZhHi1Wh7KYeljlQO5vINeCPbgKjEhQVkzSx39zxt1JjcZ7fIdgwL9JKL1X5YKN4kFXIw4CiqpGKoFvinPY+CZTJD+FZGCccuUYREPbIhOdO8aBzkyYvrmtHslqfPVtA2k8M7sB+VMqW2E088q6bEjm9YH5qg1qs2tYuVF6WcFUw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794343477; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9iGjQx46W2MXVrCn0wgOootEUnd2i1SnVfH6gaH4IH0=; 
	b=aNcgVpJbLLaq5NiFkX1poPjT+HjETebPZb8zgNRat7bdZU8GjHFtuQxle1IBKuFsLAhB7wO8kVMdp1Ri2ik9La1qxKud7TYmL4/zaSRrRMScwIgiYceOgOIN42sPZ2D3gcaohL6E50Tfqos2eN2kVPAmTsmOCg0nkyyLsjRCihE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: a=rsa-sha256; b=AFoWXKKn35kQBe6kLa033wHmyNGXDThlbthHfW2nUD97XKJGPRME+VXrkGF35EKlF99UDQFLJv4dLuhz3oO7ikG0nzht8IW50CIW1VGf1VMFGQVOoWIrC6l14krbjO0uaFFbPCWvDCA2vECh1HPpg04bQRBAM317d1fSkY1oeF/wdkADcHcw66uqUnzgXzOa2/JYFmCTGFn3amBOtwQANC369HdMefZWE6jY1ykyBJLAhyq2kfmks/FY7uFh94+JwMmXzk81N5wuiqvYH5Wsh+GATT7AMrl+rXlwSWxb8MRY772kWWSafYU5amr6g6sCMVkMBkXHpUWmdHgimIG+Uw==; c=relaxed/relaxed; s=zoho; d=machnikowski.net; v=1; bh=9iGjQx46W2MXVrCn0wgOootEUnd2i1SnVfH6gaH4IH0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794343474245711.2446390091858;
	Tue, 10 Nov 2026 12:44:34 -0800 (PST)
Message-ID: <88fa8559-6253-4bfd-ae42-55a127c25c27@machnikowski.net>
Date: Tue, 10 Nov 2026 21:44:31 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 3/3] selftests: drivers/net: Implement ptp4l
 sync test using netdevsim
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org, almasrymina@google.com
References: <20261108201503.85000-4-maciek@machnikowski.net>
 <179425610058.994134.1147534198857672730@kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <179425610058.994134.1147534198857672730@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External



On 09/11/2026 21:28, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 5
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] When ptp4l fails to start, ptp_sync_test() in
>   tools/testing/selftests/drivers/net/ptp.py reports it as a sync…
We may improve that once we implement more advanced tests. For this
version I consider it a non-issue. If the ptp4l fails, the test fails too.

> - [Low] The test says it checks that 'the follower locks onto the
>   leader'.
This is as designed, s2 means they are relatively close which is enough
to prove the mechanism works.

> - [Low] In ptp_sync_test(), the local temp directory is created at line
>   75 (`cmd("mktemp -d")`).
Nit. May be improved later, but not a dealbreaker - worst that could
happen is we'll have a temp dir after running the test

> - [Low] Both ptp4l instances turn on hardware timestamping on their
>   interfaces (tx_type=HWTSTAMP_TX_ON, a PTP rx_filter; netdevsim…
That's how it always work. Next ptp4l instance will clean it anyway

> - [Low] _require_hw_timestamping() only checks `ethtool -T` for the
>   'hardware-transmit' and 'hardware-receive' strings.
This is only a safe check. Irrelevant

> - [Low] Both ptp4l command lines in ptp_sync_test() use the default
>   tx_timestamp_timeout (no --tx_timestamp_timeout and no config file).
That may be relevant if we ever plan using some non-compatible NICs in
the HW setup, but we won't enable all ptp4l arguments.

