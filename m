Received: from prod-dose-smtp-1.daouoffice.com (prod-dose-smtp-1.daouoffice.com [35.216.61.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C231A6829;
	Wed, 14 Oct 2026 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.216.61.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941133; cv=none; b=YDJGzFTGWtYOtj2g6QwfrMiOAhynFHc8OWeCxIf46PysdHa/3YaAmuvLk6Cvy9Y9If3BL+b2mxu09UiTfS/WBs97PpUeUEt+yMeJy0boAS42Sz0xProDnLJdBdaPJGDg6+PW7U6yedCC20PIRkyx1Kl8VFG2PdGumMjsdQ2z7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941133; c=relaxed/simple;
	bh=NBSUZvFFWhsw/ZAXjKlXfwvnbLeBACh0wQC2xxUwMtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ggkf6aYMlwOreE3mXv0Bp7E2MkeQp49pUUTSGjk7DtoIBc3dBirMjNnkXa/ZfmITAEIgefM34tQPJLpR5qEjwrB/sk4I5VGuaIKsFgB6BV62ZONLLoyp5y4R+pajKY8/OddRA10Sn1RWTn17wO2qVx7SlMckJobVl05xzacVOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pribit.com; spf=pass smtp.mailfrom=pribit.com; arc=none smtp.client-ip=35.216.61.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pribit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pribit.com
Received-SPF: SoftFail 
	client-ip="106.245.249.210" envelope-from="his1415@pribit.com" 
Received: from [106.245.249.210] ([106.245.249.210]) 
          by prod-dose-smtp-1.daouoffice.com ([10.37.10.8]) 
          with ESMTP id 1791940430.596885.140076090615360.prod-dose-smtp-1
          for <>; 
          Wed, 14 Oct 2026 10:13:50 +0900 (KST) 
From: Hong In-su <his1415@pribit.com>
To: steffen.klassert@secunet.com
Cc: sd@queasysnail.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	his1415@pribit.com
Subject: Re: [PATCH net-next v2] xfrm: add ARIA CBC and CTR support
X-TERRACE-DUMMYSUBJECT: Terrace Spam system                                  *
Date: Wed, 14 Oct 2026 01:13:50 +0000
Message-ID: <20261014011350.147304-1-his1415@pribit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928020256.46391-1-his1415@pribit.com>
References: <20260928020256.46391-1-his1415@pribit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TERRACE-SPAMMARK: NO       (SR:7.03)                     
  (by Terrace)                                                   
X-TERRACE-SUPERWHITEIP: pribit_com_packetgoOS
X-TERRACE-SID: 1791940430.596885.140076090615360.prod-dose-smtp-1
X-TERRACE-CLASSID: Terrace Spam system                                      

I'd like to follow up on the compatibility alias discussion.

Steffen, would you prefer to remove the .compat = "aria" entry for CBC in v3?

I'm happy to follow your preference.

Thanks,
Hong In-su


