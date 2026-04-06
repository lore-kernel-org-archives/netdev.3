Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72026B764;
	Mon,  6 Apr 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489440; cv=none; b=gtRSJdOYCEGeezQox38kp3O8UIpzic2RBxgYjsQgtItRMOl0wXfM1RuhiPk3BAYYdjOJrgko8udp2NJZPtrYb3oS8aHOsOGY9Cg5ghvOwTRAxVCycxw+AylFN7CiEa5uvUYvKhDDeMNO2FhPPRKIv2K2MbLh6oV4ppE95bQLf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489440; c=relaxed/simple;
	bh=LDjJlJmuOzTWy74Nn0yC7pN0AJ7gm1ZbIoZKkfLC0iI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFnkiOkb0IF4kawvOktxskflc5yus5Bupe7iCTpfCnhzrIMaqsVC6O4wsOPXTvVY/SoWVeRBx82ZFVvBNNzkBlvlxiO037VCMfL7bpJNIexahLIdDcow2i3FLln4AtMFgmnSn36/41BB59tWtCLehkwbdqMzoJWFn9JWaoTgKJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egJC01RC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egJC01RC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739AFC2BCB0;
	Mon,  6 Apr 2026 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775489440;
	bh=LDjJlJmuOzTWy74Nn0yC7pN0AJ7gm1ZbIoZKkfLC0iI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=egJC01RChEg3XaPOJZLzXSgjgNyooqWxgYJ10fX9QHFXMWJPDBZ8AoQus6+iphM8x
	 QF1XzAGmDejTMxAuqUDmxcxpdFd5SS/n5qMUEXI/K2B0K+81euGoXD948aAFfH9awB
	 8McfBmfd4oXw4LjrVGfSFLCSbfSXXVb1vJcweBKlXNZWL4JJc4nuL/ibzGZ0da4mbe
	 OSEh1OKp6lUyUEpbqf2G5NkxE/6IRmnrREtvC4S3P+LOsRQBYaexFU9LTkmV4ZxWtG
	 1aEq0/WiumllW6GY4373jJfsPBFDU5efiR+OwvNFmqcn9l8TMUETEdyM8BYrFvNl+d
	 wcR6BEVNf4muQ==
Date: Mon, 6 Apr 2026 08:30:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Michal
 Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, Prathosh
 Satish <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, Pasi Vaananen <pvaanane@redhat.com>
Subject: Re: [PATCH net-next v2 0/5] dpll: zl3073x: add ref-sync pair
 support
Message-ID: <20260406083038.0690bafb@kernel.org>
In-Reply-To: <20260328080624.593916-1-ivecera@redhat.com>
References: <20260328080624.593916-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Mar 2026 09:06:19 +0100 Ivan Vecera wrote:
> This series adds Reference-Sync pair support to the ZL3073x DPLL driver.
> A Ref-Sync pair consists of a clock reference and a low-frequency sync
> signal (e.g. 1 PPS) where the DPLL locks to the clock reference but
> phase-aligns to the sync reference.

Hi Ivan, FWIW we're waiting for the DT review here.
I suspect some of the DT maintainers are AFK for Easter.
