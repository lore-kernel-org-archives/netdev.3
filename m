Received: from prod-dose-smtp-3.daouoffice.com (prod-dose-smtp-3.daouoffice.com [35.216.20.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2432AD0C;
	Mon, 28 Sep 2026 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.216.20.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790561647; cv=none; b=jPFLNd4yuE3kK25zOfiC8Hr6F0jmRs2GdxDy0RZoH8wqzvWEOnHIXJkV0qpfVrvuCK9hHVKyecccshtXYXzUvB/2L7cJN/dZd58NboU3rIzSgbX8e47rSZ8XxeQ5bQmbjP/bTknxLnOjEShv1CtmVH+svOdONZarsVrD4JW/GuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790561647; c=relaxed/simple;
	bh=x3zf1Xl0wsIvPT6bm7t0Yf0mLzEmwWdddKqAYGFSdVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2QLDCaMECRI/JqJwUHxFc4OmX4M8WC7sCGaddnJY6ixx3VeMncjTxokWiZTOsjePnzsr8gM5hkWzGGNvyddtXOWUmAONSN4+TVEf/oHuNf0aN43OWum3Cgwy8gdn7FpdI53DCLCdsNJoRmj7QfrYH8+qElqKwthJViNAyahCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pribit.com; spf=pass smtp.mailfrom=pribit.com; arc=none smtp.client-ip=35.216.20.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pribit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pribit.com
Received-SPF: SoftFail 
	client-ip="106.245.249.210" envelope-from="his1415@pribit.com" 
Received: from [106.245.249.210] ([106.245.249.210]) 
          by prod-dose-smtp-3.daouoffice.com ([10.37.10.10]) 
          with ESMTP id 1790560976.584039.140478611711552.prod-dose-smtp-3
          for <>; 
          Mon, 28 Sep 2026 11:02:56 +0900 (KST) 
From: Hong In-su <his1415@pribit.com>
To: sd@queasysnail.net
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] xfrm: add ARIA CBC and CTR support
X-TERRACE-DUMMYSUBJECT: Terrace Spam system                                  *
Date: Mon, 28 Sep 2026 02:02:56 +0000
Message-ID: <20260928020256.46391-1-his1415@pribit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <arF4W6lgjp9ovkVL@krikkit>
References: <arF4W6lgjp9ovkVL@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TERRACE-SPAMMARK: NO       (SR:6.49)                     
  (by Terrace)                                                   
X-TERRACE-SUPERWHITEIP: pribit_com_packetgoOS
X-TERRACE-SID: 1790560976.584039.140478611711552.prod-dose-smtp-3
X-TERRACE-CLASSID: Terrace Spam system                                      

CBC and CTR are the modes I have tested with IPsec using strongSwan.
GCM has not been tested yet, so I plan to test it separately and submit
a follow-up patch once it has been validated.

Thanks for the review.


