Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B984594A
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774684988; cv=none; b=H75+8n2W3Ol+LsP5JPn5pt1OZzHKfsGS/4h57CaImbhHBTMNYcRPMvPhtD2oO5fztCvj+N0xdEcS8jjMTgrXObXROSopqJqJGXjSzia5zM0b7fkAkU+vKP4LnYiK70/wTrUP9FQYHDzV0t5y1E8wAZXFX2gp6YgAUd+vzwmC4ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774684988; c=relaxed/simple;
	bh=oit0KLaAi5escCY6SslspqNihNUJI82uuJ/9rHlQlm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEfYCOe9/ssrcyPbPdCwr4NuFvfidq3oR2YWZtwtxNFHKI+xJgCipidh0pYz6uD4rG3ay87yvKPsOdDwuJ6K6KBGEk0TY5MVFHJFSljyBA6U0+g1qVgrtfOS4FqmnlsHTYoYbbOVDMMYfYWGEeE0dulaOelpDrxfxhTIC56jvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTvb0FnL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTvb0FnL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774684985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktEEduJrHYftZmJ5F0RytgmsgytBO0kyRhlebnk0ce0=;
	b=UTvb0FnL043T7HjYyCNu+gYiyV5muyQ4HMMqs7jq6loslVQ90mvLff0nJ6vuW5JxPfztTa
	Ghvf855wppm49sjFjwmf/9mvwVgT9AGlLlDBi1miWAU5jRf/0fSqst8sM72AYvmvF7LSd/
	Nv/BtLKehuiiYtvYnsRiQY4eXtvfMoc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-emQn5VSUOIWoe1Hm6KDQ4g-1; Sat,
 28 Mar 2026 04:03:02 -0400
X-MC-Unique: emQn5VSUOIWoe1Hm6KDQ4g-1
X-Mimecast-MFC-AGG-ID: emQn5VSUOIWoe1Hm6KDQ4g_1774684980
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F0581956096;
	Sat, 28 Mar 2026 08:02:59 +0000 (UTC)
Received: from [10.44.32.48] (unknown [10.44.32.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EBBF1800351;
	Sat, 28 Mar 2026 08:02:55 +0000 (UTC)
Message-ID: <ce531ea4-30dd-4c42-b587-5872d00478a6@redhat.com>
Date: Sat, 28 Mar 2026 09:02:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] dpll: zl3073x: add ref sync and output clock
 type helpers
To: Jakub Kicinski <kuba@kernel.org>, Prathosh.Satish@microchip.com
Cc: netdev@vger.kernel.org, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 mschmidt@redhat.com, poros@redhat.com, horms@kernel.org,
 vadim.fedorenko@linux.dev, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, pvaanane@redhat.com
References: <20260319174826.7623-1-ivecera@redhat.com>
 <20260319174826.7623-4-ivecera@redhat.com>
 <CY5PR11MB64621FF7F9F8E5EF85C7057EEC57A@CY5PR11MB6462.namprd11.prod.outlook.com>
 <20260327165913.37642642@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260327165913.37642642@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On 3/28/26 12:59 AM, Jakub Kicinski wrote:
> On Fri, 27 Mar 2026 15:35:13 +0000 Prathosh.Satish@microchip.com wrote:
>> Reviewed-by: prathosh.satish@microchip.com
> 
> That's not a correct format for a review tag, and you need to
> make sure that the quoted lines are prefixed with >
> Outlook style quoting does not work, it makes patchwork think
> that you added all the tags that were in the quoted text again.
> 
> Ivan, could you sort this out and repost (add corrected tags from
> Prathosh)? Last time I tried to fix such mess while applying it ended
> poorly :(
> 
Hi Kuba,
sure, I'm going to repost it as v2.

Thanks,
Ivan

