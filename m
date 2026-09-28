Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69147CC9E;
	Mon, 28 Sep 2026 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638178; cv=none; b=oZcSwNEaIFcxa1h6jxodP0DUKJSe0yozEFMRcS3hEks+8YbE7VRIsvvsdOA/AzEgm1O6uJGxUwgyrI2iPTlL3z2pW2FP0hAtvGGuAT56tAUMisopfqVI2ks3WWg6DrO1MWUEy9b/lgMeFNZsYOWnTUdbD3dTP87kbomvm71T5ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638178; c=relaxed/simple;
	bh=ncpPuOTmPAUNAvy5qOa+qYhIZ7wGVtenPSo4eXBzSq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QV71eriHgVWYN6YDIT0xRljo2mG2lmUNrBVD57NlPajEeEWJ2T6Ga/l4ZsZ3gpqsnyAnV2C3UAl5gdbEAZbBo05oph+Ep0RRAIneM2f4N7kyr2DqVVFDKIJDZxcYLZlFd3o0W2YySSpradrx0S7Q9IoDMWOcC/Gte6WTpce5o7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGCPTlC2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGCPTlC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616151F000FF;
	Mon, 28 Sep 2026 23:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790638176;
	bh=ncpPuOTmPAUNAvy5qOa+qYhIZ7wGVtenPSo4eXBzSq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CGCPTlC2HBuPCwdpcTv9YEir6QDgIqgIllfn+cklYBPEDpFeGeNzPO1tw07yPj1ip
	 Ga39CgI6bcgWs+4HVhs/sYHhLN30dD0UvFAHswHVy/1R+JGfRvPLzTWF8nnfW8Gooa
	 od8oZ0PNAe48apWj3rL1pW8NHHuLkfVMDo+6IFnO4f9hJ65M9z7D/dh4IdibIt4Uav
	 1fLvcQqKvUBAMlvRDQxzk5LiMVINcy0tuHbDgJ7a2UgWJQH3kXRYNL0BZxhiZ+qZtd
	 higxKuF+dcWl+u8t0T2qPpSE/JDxeHowvBgK2SSCXwgjOp3uOqyGmz6RRS6X9xnDMf
	 1RzDANr8FGxaQ==
Date: Mon, 28 Sep 2026 16:29:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ali Rouhi <arouhi@sitime.com>
Cc: "jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "arkadiusz.kubalewski@intel.com"
 <arkadiusz.kubalewski@intel.com>, "ivecera@redhat.com"
 <ivecera@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "cjubran@nvidia.com" <cjubran@nvidia.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "prabhakar.mahadev-lad.rj@bp.renesas.com"
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, "dev@kael-k.io" <dev@kael-k.io>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 00/14] dpll: add SiTime SiT9531x DPLL clock driver
Message-ID: <20260928162935.713c28c8@kernel.org>
In-Reply-To: <20260921201108.42676-1-arouhi@sitime.com>
References: <20260921201108.42676-1-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 20:11:08 +0000 Ali Rouhi wrote:
> This series adds a DPLL subsystem driver for the SiTime SiT95316 and
> SiT95317 I2C clock generators. Each device integrates four PLLs with
> automatic reference selection and on-chip TDC phase-offset measurement,
> and is used for synchronization in telecom, networking, and data-center
> timing.

This is now the oldest series in patchwork. I'll drop it based on AI
feedback Please LMK if none of the AI-reported issues are real and we
should restore.
