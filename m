Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444BD37269B;
	Thu, 17 Sep 2026 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656498; cv=none; b=RVs0SqM/b/j3yuZYjpFkRLlzJ9ZZuA6+0xATFwK0qZgXM9LIy+QqVyK9GqrrO/UABJk7FjWtKnD5tLv48Zb+iCNON68+arQaE/aVzCk9tK7a8+dm12iuXcqomxpvyIHs45wNfTcJnblPd+qlBxk97uIIjNSpVeXl5P3HLDTkoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656498; c=relaxed/simple;
	bh=/NnbWJAlZgJf+7xfVx/cUz2TPM01/Z1NBNzBZo66h6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nB4Iq/SGkJav/HIBFnct231IyyoTHBwFMKVlQqmjcu8v4wG1qWeu4ta0oh357885p7TBteE7ECy79nBuWpPQdjFK+EbRAgBXPKu6d7GiU2R2DdpkuhokCaEzsbm53p939Jf922vHNiJ1meHLcGVBjrpRGDUTTVJRTDL77NKBb4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYc5167b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYc5167b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E43A1F00893;
	Thu, 17 Sep 2026 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789656486;
	bh=/NnbWJAlZgJf+7xfVx/cUz2TPM01/Z1NBNzBZo66h6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YYc5167bHak/3fkJzclyzTd6DW7MuObiydW59vgoLoJu/xs/B6w3fdZv1hji9TsOC
	 DouT2jcQyoRw3fYYjmkRAMR2p0EgujNTOh/W/N+K1zXv77KFU1JNb7KbrsY3yRxVMG
	 evWXNkUXYv7ek1fmBdDvvLWW+muMCeBTcA0uy+lis5q+k6U4epUpfSWroYRiYcy3TW
	 6G/xeSKl57RsOXPonqf08EdOLnHMFxN44Z66cf4q5HCfWYGkfu6RuWp9xiXEaxOWQD
	 feOiEWkuz4CpJfIWYwQr/Fsb4xq9vXtwxGhl19QWanSm8t3rNSQhtQVaCXUJEcoCzC
	 0Q5VbjG13XcAg==
Date: Thu, 17 Sep 2026 07:48:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Jeff Hugo
 <jeff.hugo@oss.qualcomm.com>, Richard Cochran <richardcochran@gmail.com>,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Vivek Pernamitta
 <vivek.pernamitta@oss.qualcomm.com>, Sivareddy Surasani
 <sivareddy.surasani@oss.qualcomm.com>, Taniya Das
 <taniya.das@oss.qualcomm.com>, Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Vivek Pernamitta <quic_vpernami@quicinc.com>
Subject: Re: [PATCH v3 0/6] bus: mhi: host: mhi_phc: Add support for PHC
 over MHI
Message-ID: <20260917074804.08818813@kernel.org>
In-Reply-To: <20260917-tsc_timesync-v3-0-6826d5d2d527@oss.qualcomm.com>
References: <20260917-tsc_timesync-v3-0-6826d5d2d527@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 12:38:01 +0530 Krishna Chaitanya Chundru wrote:
> Subject: [PATCH v3 0/6] bus: mhi: host: mhi_phc: Add support for PHC over MHI

The MHI "bus" is the worst abstraction I've seen. You're turning it
into "qualcomms corner of the kernel". The PHC drivers belong in
drivers/ptp/

Carry this until told otherwise:

Nacked-by: Jakub Kicinski <kuba@kernel.org>
