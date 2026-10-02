Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0A46AA6F;
	Fri,  2 Oct 2026 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929963; cv=none; b=i0Qalay4YegbCuqKZyL8QRLhYunN3DLp6G4v7gu46ZDUOTKVApFXbf9sS+NAZ7AVR2h4F0xLNO0cwkTk/bXRhDKYWgF5Fo8idCT1wwxa7wLMeCNgn0Jvdy197CMCKpGiRy6vxJwKN+Kl9Gd79jyF1hibu9eNuiu/emBbCRXIaVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929963; c=relaxed/simple;
	bh=njyLW2UtDcbiN0W3TdJ0xeuv6mgrNjxBq7CyDsFWJu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBxqH6LiazwNjBBHi7/IxV0fL2V6AQTDrm7nW/rwn7pJ/D7orYNwnPRWAC2Je20EXxZbbZ+6AKnY+Th6raLdYsuVLF5TzqhKSSnT0WvUMqxRAOwPW0qjCliSdCFLUQbKKZcb9Ab4KZO170lQ5nSVu4nZClo4LhQt8UdfJ8vkgDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8qY02aQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8qY02aQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5926F1F000FF;
	Fri,  2 Oct 2026 08:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790929961;
	bh=3w5wxiDZOhPLHQoea7TkZz2w5L1AzLS0BHSsxDUFa6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C8qY02aQ8f1wHPD3EdVf3nLxS6MUHwpeyijZWOSCDNJcOLJbxIAGXdB1o9GoIE8N+
	 4BjfHw+STGGXmT7qm72MAj1nX1rjSbo+AFIwvPFL05UTg8pbu3kdnwr1CtqM3dpOD+
	 CPqSMLAKaxSK2Y/sVPwZAhcbnGOzmhWkGc5tN9Y+91RtkyCQMNm+J8Y1oGj6mzuXr2
	 GJ00Fq9MjXTK/weOthR2/1zkRZoZdJKuNDhzKLa4cbCEr1/qdvKe8L3HCK1B/0/V3o
	 6/WdqAdhnkBqaV003m665BQU3xLhv2yXGoMdEcjTYAwxqK9AVjUOu8HOU0f7TjQw7f
	 fJGLMxyNohL3A==
Date: Fri, 2 Oct 2026 10:32:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ali Rouhi <arouhi@sitime.com>
Cc: "jiri@resnulli.us" <jiri@resnulli.us>, 
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, 
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>, "ivecera@redhat.com" <ivecera@redhat.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com" <cjubran@nvidia.com>, 
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v11 01/13] dt-bindings: dpll: allow hex unit
 addresses on output pins
Message-ID: <20261002-vigorous-cyan-pegasus-d44fad@quoll>
References: <20260930233714.87679-1-arouhi@sitime.com>
 <20260930233714.87679-2-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930233714.87679-2-arouhi@sitime.com>

On Wed, Sep 30, 2026 at 11:37:16PM +0000, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> The output-pins node matches its children against "^pin@[0-9]+$", while
> input-pins takes "^pin@[0-9a-f]+$".  A unit address is the reg value in
> hex, so a device with more than ten outputs cannot describe the
> eleventh: dtc wants pin@a for reg = <10>, and the output pattern refuses
> it.
> 
> Use the input pattern for the outputs as well.
> 
> Fixes: 0afcee10dda1 ("dt-bindings: dpll: Add DPLL device and pin")
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: Claude:claude-4-opus [chat]

: LLM

(see current docs)
With this fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

