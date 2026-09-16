Received: from prod-dose-smtp-3.daouoffice.com (prod-dose-smtp-3.daouoffice.com [35.216.20.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCB231B130;
	Wed, 16 Sep 2026 03:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.216.20.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789530355; cv=none; b=EfhJOeZ1nVt5aPGFZoYBtMhgzr0m9jiTJYVJmMktCjYy6Og/T2/0wC1MP97tTKrmI0lpLAaXVjPzbeHd5IZiRns4N1gucc1ZG66DKFznFVzsd35vjIWIZawrzL8Ep7Rj0DHYN5Q/Sh8G0ggDE3sXqnvnebwmItejqkz/nmPjrPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789530355; c=relaxed/simple;
	bh=9l7RKG9cnoYjM91nZDIjjU7cP0tBoJdeK4+meSeZMqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KD9joFScDh75ZBHjzr4I1ClryNt8p5vnih5NjkTIKMDOPJa8zwKQBPkfrCDb3xQbogZLu1KF7Fw1XGo9qBe/TVVYphjeRPAukThOcGM5Kj8WwweyN196QJrBuQdJj3kGOmd5CQtjnOp7noeWu0UrP85BzZhlfuErOvsnlSGc2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pribit.com; spf=pass smtp.mailfrom=pribit.com; arc=none smtp.client-ip=35.216.20.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pribit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pribit.com
Received-SPF: SoftFail 
	client-ip="106.245.249.210" envelope-from="his1415@pribit.com" 
Received: from [106.245.249.210] ([106.245.249.210]) 
          by prod-dose-smtp-3.daouoffice.com ([10.37.10.10]) 
          with ESMTP id 1789530177.189980.140435320108608.prod-dose-smtp-3
          for <>; 
          Wed, 16 Sep 2026 12:42:57 +0900 (KST) 
From: Hong In-su <his1415@pribit.com>
To: netdev-bot+sashiko@kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] xfrm: add ARIA CBC and CTR support
X-TERRACE-DUMMYSUBJECT: Terrace Spam system                                  *
Date: Wed, 16 Sep 2026 03:42:56 +0000
Message-ID: <20260916034256.26192-1-his1415@pribit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178902269711.219967.15840470225546817223@kernel.org>
References: <178902269711.219967.15840470225546817223@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TERRACE-SPAMMARK: NO       (SR:7.48)                     
  (by Terrace)                                                   
X-TERRACE-SUPERWHITEIP: pribit_com_packetgoOS
X-TERRACE-SID: 1789530177.189980.140435320108608.prod-dose-smtp-3
X-TERRACE-CLASSID: Terrace Spam system                                      

Thanks for the review.

I addressed both issues in v2 by dropping the duplicate compatibility
alias from the CTR entry and aligning the default key sizes with the
existing AES convention.

v2: https://lore.kernel.org/netdev/20260916023135.26043-1-his1415@pribit.com/


