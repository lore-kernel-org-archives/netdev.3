Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065E282F1E
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924302; cv=none; b=OQHXF21iLpASlpoclkY/KC34CY9HZOGup7Q8owGqWwIfCB8SDnZW8pVcedApPgSijFvZZgcJ/16MNo0najaSm0t0lJ8uAnyIf/pKtzRmXn5LY+uybQitEZIlFmFEZTRTCjGZFWXHv7Ia4KYucKfYW7o/L2qgWt73/mdAID3SAY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924302; c=relaxed/simple;
	bh=KBJjZ3rtrWzA6LfcNBH2ql62shDyhz2gq6T6NDoUIDU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N2V4HUZYVjShHdZiMoKks9RkOQwNJAt9UeqxLA6vY1Q5g3eQQA3JcbHO/Rqf6WNnlKUjM6jVqzJcBvzHc1jkJHvsELUV7p9xQpV11kNdavF3uzgp+bW4bnG2lgjMjrIilK/CVANhyeMsZRvjHtYV1dZNa0QxnZecbdsGeRvGyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HM3hJ02Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HM3hJ02Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790924300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeefcwViSjK4cRmRqKaeNJ2r4zTSmvm+YXtljcz7LeA=;
	b=HM3hJ02ZA43chFkgtB0cosK9yYQQcWKM8Ia3KCN0c692wyPEc+659NYigRb8i90y3Hiv1m
	T8bHYL354jw3f7ugHyiCaLj56XS8dOr3lJ6Mha32jsQ6XqZYHtY8eGaIkTsQIHFr3iC0Hr
	Qw9Iu2OBbsPyHHaT8aWzA7VOnDbkDdU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-mePLdwovPbOGP7PqBw4jPQ-1; Fri,
 02 Oct 2026 02:58:17 -0400
X-MC-Unique: mePLdwovPbOGP7PqBw4jPQ-1
X-Mimecast-MFC-AGG-ID: mePLdwovPbOGP7PqBw4jPQ_1790924295
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AE541955E7B;
	Fri,  2 Oct 2026 06:58:15 +0000 (UTC)
Received: from [100.90.87.156] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F5CF30000E4;
	Fri,  2 Oct 2026 06:58:11 +0000 (UTC)
Message-ID: <12e7f4ee-8e1d-4814-9160-7fe8aacefc5d@redhat.com>
Date: Fri, 2 Oct 2026 08:58:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] dpll: zl3073x: fix output pin esync and sibling
 notifications
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Min Li <min.li@microchip.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20261001080648.1424172-1-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20261001080648.1424172-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Need to send v2 due to coccicheck failure:

+/srv/nipa-builds-contest/testing/wt-cocci/drivers/dpll/zl3073x/out.h:141:63-68: 
WARNING: conversion to bool not needed here

due to this line:
     return clock_type == ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC ? true : false;

Thanks,
Ivan

