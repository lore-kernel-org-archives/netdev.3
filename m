Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0337C0F9
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134780; cv=none; b=Oz33Qgg2h7sLE9sfFCq/g8/W3cABr05yn7cfFMVcjIP7d9XzhVZMtPFy1pOYIA3YdLt4LzWa1ZHJcI2B2mBlZ2UT006BVfAp2I+7V5epqFACtV+lE14igKr0NbezmBlQcgYYuNiBTQ9UwLhNosXSb0KvSLDLei67DBsH8MbF0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134780; c=relaxed/simple;
	bh=Y+d4ctARhwfgjfgfwvmOrOYen9VVVUD0V/7Rc1Mpu8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcZEiXHWCsODQQuXTv2VVixOx4SU648kjgkGOBbBlNrs0DxtkgaoRx7jf/q4Ue39kfkIQJ4BOABB2kUVPYSwgBj4FrIdxbvfLb8Y0b1qw/X53BDNov0dpY87L9/4Hl7Y0/roGbAJwouNm0yaaawMN4Q7/W2Io7QPiamCZG/ECNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsonogLV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsonogLV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775134771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hcc2Axi1gKxuYf+5fOFedCWziDqiQotL/QAp/9rxyM=;
	b=FsonogLVOlLp3KgWspU11mtgKyrl/h018GLYBwbuGv6BI74dn8NvvYuM4V/CdnvXHthjbN
	sJYojcIAQLFlzK8gOcx/VdyoXueOcesZF9cENy5GN975tKh4CwPjh4negyFs3j693d/BqQ
	qBc/uOrqan553GcRPKhKgf4Z1P2+z5A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-92AsWuWWNbWNovgjjpF5-w-1; Thu,
 02 Apr 2026 08:59:27 -0400
X-MC-Unique: 92AsWuWWNbWNovgjjpF5-w-1
X-Mimecast-MFC-AGG-ID: 92AsWuWWNbWNovgjjpF5-w_1775134766
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDE5E19560B3;
	Thu,  2 Apr 2026 12:59:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.195])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08BAA30002D2;
	Thu,  2 Apr 2026 12:59:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: michael.dege@renesas.com
Cc: paul@pbarker.dev,
	niklas.soderlund@ragnatech.se,
	kuba@kernel.org,
	yoshihiro.shimoda.uh@renesas.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-renesas-soc@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net
Subject: Re: [net-next,v3,04/13] net: renesas: rswitch: add register definitions for vlan support
Date: Thu,  2 Apr 2026 14:59:19 +0200
Message-ID: <20260402125919.234448-1-pabeni@redhat.com>
In-Reply-To: <20260331-rswitch_add_vlans-v3-4-c37f41b1c556@renesas.com>
References: <20260331-rswitch_add_vlans-v3-4-c37f41b1c556@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: renesas: rswitch: add register definitions for vlan support

This commit adds missing register and bit definitions for vlan support
in the Renesas R-Switch driver.

> diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
> index 340524d995ac..15d3fa48b0e3 100644
> --- a/drivers/net/ethernet/renesas/rswitch.h
> +++ b/drivers/net/ethernet/renesas/rswitch.h

[ ... ]

> @@ -847,6 +903,98 @@ enum rswitch_gwca_mode {
>  #define FWMACAGC_MACAGOG	BIT(28)
>  #define FWMACAGC_MACDESOG	BIT(29)
>
> +//FWMACTL0

[ ... ]

> +// FWVLANTEM
> +#define VLANTUEN		GENMASK(28, 16)
> +#define VLANTEN			GENAMSK(12, 0)
                                ^^^^^^^^

Is GENAMSK a typo? The correct macro is GENMASK, as used on the line
immediately above for VLANTUEN. GENAMSK is not defined in the kernel and
will cause compilation errors if VLANTEN is used.

> +
> +// FWVLANTS

[ ... ]

