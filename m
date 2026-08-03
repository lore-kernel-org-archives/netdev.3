Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638C2D7DF1;
	Mon,  3 Aug 2026 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741464; cv=none; b=CW/5/yYGxnq4A94wixllIxyL9EK4+H6DX6N+RwrP10ZvkZM1f5u8tacVWnMTBGd9sJzR0Y5IcD77bM6IogVU89b2TRnxzbVkL5VyheGPwfhfR4LtdRoZDuV/DYlvF4VFOfAMIYmofYabRDDYCyn99eAV5K09/HPWTuH3o116nNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741464; c=relaxed/simple;
	bh=LD2TIzgcDb4YKHl1qmeb1sQVgyqKCBpsYE6NHa63ROY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrePw/YLqLKBfJSrYEYi1z1bdFX3Eaf7Iv52EiOLIAvRgOLYY/2Oyzl56DHUlZoLLFmSWgp/0G7e7N3pihWysb0zBW9TZgwa8Qtd26PYJidp2f1wbQWnH2aviz0RwIs4awYh90CoHQ8VanB2jun+vjRJhIab1NT05ueldpykvE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo3wQoOr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo3wQoOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A151F000E9;
	Mon,  3 Aug 2026 07:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785741463;
	bh=tZlyZ8OtK+x/YR8QtferAl2xQ5Om0t8sQl4utKm0cp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bo3wQoOreaubTd3DUEAPaRrVOdGtsgzM7wLZUvQfbI2W7tMGr+t9G4rZJ134wzq9j
	 Yxn8CAXu6CaYsLq6P5HPN2vsEIBatg6KHtHdl1QCrmgDXC62KhCkGmHFNvufdg+y1w
	 kQHNtDXcINesnycR5phv6WvIqfhWbXDTQ6wqNCjm6UM52KIMiT8CFOIC2iRKSQY9Qg
	 q+VRe4tFYLjcpnoZXq3n9ErPCGB3vlsII9osp+aVMN+Cp5XTkdgv/2DpKOD1mxL7vE
	 fOyUnLIrlLzCAKLESiJFskgnZ2DXzSYcQTLAa6Z2itXZ4tRPVhO+ANSabeuQljO0OA
	 awIMKDPAmDsHg==
Date: Mon, 3 Aug 2026 09:17:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ali Rouhi <arouhi@sitime.com>
Cc: "jiri@resnulli.us" <jiri@resnulli.us>, 
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, 
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"cjubran@nvidia.com" <cjubran@nvidia.com>, 
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 2/3] dt-bindings: dpll: add SiTime SiT9531x
 clock generator
Message-ID: <20260803-musical-fat-hornet-11aa37@quoll>
References: <20260731180951.65725-1-arouhi@sitime.com>
 <20260731180951.65725-3-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731180951.65725-3-arouhi@sitime.com>

On Fri, Jul 31, 2026 at 06:09:54PM +0000, Ali Rouhi wrote:
> +                pin@1 {
> +                    reg = <1>;
> +                    label = "clkout1";
> +                    supported-frequencies-hz = /bits/ 64 <25000000>;
> +                };
> +            };
> +        };
> +    };
> +...
> --
> 2.43.0
> 
> This email message and any attachments are for the sole use of the intended recipient and contain proprietary and/or confidential information that may be privileged or otherwise protected from disclosure. Any unauthorized review, use, disclosure, copying or distribution of the information included in this message and any attachment is prohibited and may be unlawful. If you are not an intended recipient, please contact the sender by reply email and permanently delete and destroy the original message and any attachments, and any printouts or copies of the message and attachments to the original message. Thank you.

Sure, dropped from Patchwork.

Best regards,
Krzysztof

