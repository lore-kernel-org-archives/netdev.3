Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4831C495531;
	Fri,  2 Oct 2026 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948917; cv=none; b=qjUzdK/A4nnpSoOVj+iNxoGa8LAcjQBmeB2zcaugboaq13Lkj3vJwslNy0KjThYBtlRzI4UDeEcsIxzGAuugY5YvDcojhCs8EyQ85/sXQw8P6PBlf9AeAw3IoC0EjyaPgEMUeL10IERM6KVWf7iqH4gUa9RX9xIwoZxtkSCjR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948917; c=relaxed/simple;
	bh=AeaX8rRa1HQ8lZ1H1p05fCG1MX8TmQxVKVAFGDUqo8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jt7kv6p3Z6LDgSzO5t1+IO1AF4ECvCZNZBKCFwKiUoXLTY3wRfdmJmOVOof54KeDKdQgOzIOROHEYvCvD1Bb6FPdAONSnbI154Reh2VsXCT1jF+nk9isM0ykL/Gdl8/MZ+GN7obgTopU/4c8y7UgMzn8Tn4Xrk+bg5HwJHPuD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=YfnVQ6vv; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="YfnVQ6vv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=YfnVQ6vvht5Wv3NX0PSroEEzG2Rqo4VMJeQfkYG4+wd2lHGeUCvc0zdH9J4nZ/OYO8RhY5cqdmGhw
	 9H1SGuFaMZ9kl6G/LSkbQ9QuBIvph2bcrd19y3E7CyKzviEXjxvV5oxj6CaOCub0tsW/LJrF9zuC1Y
	 T5WrM6N4XnetayBQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56abfb569fa8-958ba;
	Fri, 02 Oct 2026 21:45:15 +0800 (CST)
X-RM-TRANSID:2ee56abfb569fa8-958ba
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.22.250.209])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16abfb566e96-20939;
	Fri, 02 Oct 2026 21:45:15 +0800 (CST)
X-RM-TRANSID:2ee16abfb566e96-20939
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: fix NULL dereference in skb realloc fault injection devname filter
Date: Fri,  2 Oct 2026 02:44:32 +0800
Message-ID: <20261001184432.357108-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ar-Hj5DhKuZeUisY@gmail.com>
References: <ar-Hj5DhKuZeUisY@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 01, 2026 at 10:30, Breno Leitao wrote:
> I think something like this untested approach reads better:
>
> +	if (!net)
> +		return false;
> +

Thanks for the review, Breno. Agreed, this reads better, and the fault
is meant for skbs on a network device anyway.

I sent v2 with your suggestion and added aV Suggested-by tag:
https://lore.kernel.org/netdev/20261001182813.353004-1-yanhaishuang@cmss.chinamobile.com

Thanks,
Haishuang


