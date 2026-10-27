Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114389;
	b=b0QIC+PN5v3ztRrfLmvkowcfL/DE9shHLHIHo6Vs2En6mAYDVuQfxuj15a0aKbp4OGB8
	 An4O0E+w6rHxyt/cKFrMXQrOeHJBYfXxWLAGDxSes0SzjSrveFz+jswvrDqt4Fi44q16U
	 rPqI/uTJnFmgH8R7gLqc4VI2Wb2D7iT3MI4IvW4qAz7CKS756IAGBXX+Q1SIozq1NDnm7
	 udr/FFmPiR2/JDVcCiDCnivayYV7z0xNUci9JFaUMe4wKSeyTnRRHPIlzgAsbGTffC69v
	 sYp4dQQVDc3/U5rGqcYronhLnURG6sucyQsrBlsr5vJjXN+HHbKcmLwcgYum/7JWZWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114389;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=sMgUDH2AwcqoMwjXDgkudYOyFG4cLjIdTSCCeoJtqvg=;
	b=ndsMJ7XEZhUtlhXBmmb+dU+Vlvu+foKz5LO0FRDGsonU6CMhJUbPRN/cSZ2wfgMaQpHP
	 JnB4mG7CI91yEtUU/Jj3ZSmpWmJPfJOa11qbKbElmY2JGFkCX9sAPjYZLOzrTt+Zdz609
	 s9pZI6czCvbJypUyC8c1pp3llaFjKInPt501koluxMg/9pqRxQ6zHD+tif8o0nsxNzPNH
	 oftp8R7F6b4MndeP+OsoiRnyqEKGQXn7TdaQedk31Jzd/SeG2y1xjY/lRUiAuLTk8x+2L
	 sQcEmu4teLGTn0KILuReyFnW5m9Ictd5K1XBdjkFc96GGUvmH5/ztLCyCQSxs/VhiQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7jh1tBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9B8606A31E;
	Tue, 27 Oct 2026 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7jh1tBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982AF1F01829;
	Tue, 27 Oct 2026 15:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793114389;
	bh=sMgUDH2AwcqoMwjXDgkudYOyFG4cLjIdTSCCeoJtqvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k7jh1tBBsOBG5dou8fhCh+tMjVrfqZ+QyYH2YOAVR8oqdJZnj8f4I6oUNYZR81/L6
	 AApxwcBGN8jxBbomV9prXrYPjHejt3bgnfAgZy3ZCuYE5RC9rmpEuxZHT5BtMQmTAl
	 +MHFdzxsWia+XWBxbpV1GUTmGUtz04jpnds3WL3atps/Jn0SrR4Oc3UqhH7sF7/Oak
	 G/99NS4H4+bssn5vJNqxXd/gVyVgJmKfcxAHHvHnIMSGCNAPi507NWnO4Ad1TI/313
	 l6R70fGsYL6j1DoCGQ1R8gMFMqc//VvUsfRU/tvrnMgNjTMs5szsrSoBAPMxvFHGDz
	 mghJJuXIew6qQ==
Message-ID: <8fdc66b2-6047-4f3d-932f-1e6883e370bc@kernel.org>
Date: Tue, 27 Oct 2026 16:19:38 +0100
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
Subject: Re: [PATCH 1/6] dt-bindings: ptp: Document the TSCSS on Qualcomm
 Lemans and Monaco SoCs
To: Imran Shaik <imran.shaik@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Taniya Das <taniya.das@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
 <20260727-tscss-v1-1-beed14e72510@oss.qualcomm.com>
 <02792987-7ad8-4a6b-81ad-559c63174bb0@kernel.org>
 <640acacb-1704-4ee6-aa34-d6be3b30b44b@oss.qualcomm.com>
 <f5aa313d-0e23-41fa-b59b-9388839b2525@kernel.org>
 <7f6839fb-59b0-4f6d-a3f8-7579f6d40857@oss.qualcomm.com>
 <aa76425c-0579-42c2-832d-cc767703f3f5@kernel.org>
 <237b2f74-4a9b-4df2-a0fe-a7b783ed5267@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <237b2f74-4a9b-4df2-a0fe-a7b783ed5267@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/10/2026 13:55, Imran Shaik wrote:
>>
>>>
>>> On checking further, I found that our etu-slice sub node deviates from
>>> that example, since we don't have a compatible string for the sub node.
>>>
>>> Please let me know if we should move the pinctrl properties under the
>>> tscss node with per-slice names, or instead keep them under the
>>> etu-slice sub node and add a compatible there.
>>
>> etu-slice does not feel like device at all unfortunately. I see only
>> address space, so one resource, which might be enough but lack of
>> description for the subnode is not helping. I have doubts that separate
>> subnodes should be there in the first place, but if they stay, describe
>> the child node fully - what sort of device it is. Just because there is
>> independent timestamping counter does not make it separate device, just
>> like independent interrupt in GIC is not itself an independent device.
>>
> 
> The ETU is an independent hardware block within TSCSS that captures/

How is it independent? I see no resources, except address space. A
channel of some device does not mean it is a separate device.


> snapshots the TSC timestamp in response to an external hardware
> event trigger, for each slice individually. Hence the subnodes approach
> was followed and will capture these details in the description as well.
> 
> If we drop the subnodes and add everything into the parent TSCSS node
> instead, then all the arrays here must stay index aligned as per slice
> mapping. Example DTS node looks like this (QDU1000, 3 slices):
> 
> ptp@1da0000 {
> 	compatible = "qcom,qdu1000-tscss";
> 	reg = <0x0 0x01da0000 0x0 0x2000>,
> 	      <0x0 0x01db0000 0x0 0x10000>;
> 	reg-names = "tsc", "etu";
> 	
> 	...
> 
> 	interrupts = <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>,
> 		     <GIC_SPI 333 IRQ_TYPE_EDGE_RISING>,
> 		     <GIC_SPI 334 IRQ_TYPE_EDGE_RISING>;
> 	interrupt-names = "slice1", "slice5", "slice6";
> 	
> 	pinctrl-0 = <&tod_pps>;
> 	pinctrl-1 = <&gps_pps>;
> 	pinctrl-2 = <&hardsync_pps>;
> 	pinctrl-names = "slice1", "slice5", "slice6";
> 	
> 	qcom,etu-slice = <1 5 6>;
> 	qcom,etu-event-sel = <1 3 2>;

Why this is not continuous? The slices are all fixed in the hardware. I
don't get why do you list some of them.


Best regards,
Krzysztof
