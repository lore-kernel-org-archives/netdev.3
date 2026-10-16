Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA64C9E0C;
	Fri, 16 Oct 2026 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163369; cv=none; b=WcAkeu6Ez/0Df/uUDPXBQezBQuu1G/bjh5lqLEh57bhpNXtKsXgS0telbb4UmddEUlHj3qKg8pM8cOSZbWQM9EzS/d/N4qo7KBJtyeDANv1bTzf9+mRL1WGPk3My0kFmbBoZ3d7ijvOSMR6k+jpCLab4AVF4n7HxwpjRVL2qglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163369; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JrqFOc8XrF40nOFUKVIn1UaaowdXGruDKJ9FSY8u1tpqmX4nUmjld31xOraxyCsVn58IS1t6GqpBbhjMIT+Rxv0cOHZJf6wTBE3lx5ZbR4DXrUpOifWbRCoDELEA6Q7fIIx3knUZa2+vqfhrHyTfcusNd1r8Rc5q/bDBZ+FEX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+dr46nS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+dr46nS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86041F000C4;
	Fri, 16 Oct 2026 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792163368;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m+dr46nSdP2qlLIB2fmp3Kbk/BFMqVufNzirPvqKWC8uNsGwg7lgxsd7gXxlToQ0X
	 1YhneGxZX9TZZTKLenN6dG1Kh/Qf2vuGZRdZJk/m438Lt3YNdyB9vdiwow476kpzsd
	 Zt5sHxLOxok3rthvI+zVfV4IILi1hp0kGpFr5ZMTGuQP5hHWMM23cNl+fB+IC7NUlB
	 vXtm2wmlsA0NstoHv2GXKsz6Ni8ys9lHM+IXbxQFXkyUZa8LK6JJQ5Gpurib4UGtci
	 SmQ4HJSMrxN9J5zR3/KEMm5vpIzrBMBTEREWsGpG1GHduNB/r2yswnbUgT87N80/G7
	 TzMDrQoKgvmpQ==
From: netdev-bot+sinfo@kernel.org
To: Til Kaiser <mail@tk154.de>
Cc: netdev@vger.kernel.org, jie.luo@oss.qualcomm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com,
 quic_pavir@quicinc.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: ethernet: qualcomm: ppe: Fix queue access
 and port validation
Date: Fri, 16 Oct 2026 15:09:27 +0000
Message-ID: <179216336717.408196.3512649985663407159@kernel.org>
In-Reply-To: <20261016150140.929729-1-mail@tk154.de>
References: <20261016150140.929729-1-mail@tk154.de>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
