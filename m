Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742ED442B15
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633956; cv=none; b=LPT8Gkre0pdcNCcJgu8qr+n+iqdVqPPtM3Vuu5txbdGtoKXTkZeYK6Q7dqcjxTz/y3LJ8gC/+/MEPIS0rD3QwUq9boKtxe5jcRUIT7Ldm/xkxvURmqg9QFXUPabxfALyJ8+KRiP+udhOqBx7MsEreIaUsZfUp+1u1XMPgiICmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633956; c=relaxed/simple;
	bh=WXcytrduSDyZbNBnkmeB8QbyMLvLzr0igBdZRT3L+uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghySOk4CO1bhE8AjqPeRxF/OfM0IRxLIPKZdugVNpc4wX1zb0HWBVyjg300PrKF0N2p4x3qzJv+tFC9DpapTEAHpw7OJAtAI9nKMqWxFZcj3ZkUVWYckmxc2ayqhbiCgqGvkPyl7JdUqc+um4ejBRanwWx5Sd9J2yC+RCCr8xOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBJBrp3R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBJBrp3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789633942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6/VwDElwAs3PwRk14GGcfVXoVq4w63AF8VBRTlZK50=;
	b=SBJBrp3RTlm85ZJELmlt6x0IZYddc4GGpmkP4Wz/GzbFqvYfwGZHmbeRSCTBYAbAj7j9+J
	HTEybAn11n2KJo8k6cr0cr11wrtArQW4g89APpIbFG6393g/CV2ol7kD5YD2xAcPqnRR/C
	i0bJkf+/Zw86a9sqtxg0DisvggR30X4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-eG0WPGb-OJGAfgRklY_LzA-1; Thu,
 17 Sep 2026 04:32:18 -0400
X-MC-Unique: eG0WPGb-OJGAfgRklY_LzA-1
X-Mimecast-MFC-AGG-ID: eG0WPGb-OJGAfgRklY_LzA_1789633936
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C73E195DE32;
	Thu, 17 Sep 2026 08:32:16 +0000 (UTC)
Received: from [100.90.87.156] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D164A30001A2;
	Thu, 17 Sep 2026 08:32:12 +0000 (UTC)
Message-ID: <dd42a0bc-2a7f-4e7e-90e1-dc29a0745422@redhat.com>
Date: Thu, 17 Sep 2026 10:32:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dpll: reject a reference sync pin which is not on the
 pin's dpll
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, milena.olech@intel.com,
 przemyslaw.kitszel@intel.com
References: <20260915213047.1352286-1-kuba@kernel.org>
 <20260916163700.1fc4d654@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260916163700.1fc4d654@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 9/17/26 1:37 AM, Jakub Kicinski wrote:
> On Tue, 15 Sep 2026 14:30:47 -0700 Jakub Kicinski wrote:
>> CC: vadim.fedorenko@linux.dev
>> CC: arkadiusz.kubalewski@intel.com
>> CC: jiri@resnulli.us
>> CC: ivecera@redhat.com
> 
> How many maintainers does it take to get one ack? :/

Sorry, Jakub; I've been a bit busy these past few days since returning
from vacation.

Reviewed few minutes ago.

Thanks,
Ivan

