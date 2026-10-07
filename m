Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBA93B7779;
	Wed,  7 Oct 2026 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363472; cv=none; b=aSb6A+mzYa11CmtScMfMyPSN7xDxLJHdzJi2AzO+WDZphJN1iHKyqAOceKcxqSuFGtrYtdU/znSDWapE5A8POUgZNNLp9H50LE5gzhVxQZabzFvpRETp+q9vdqjlvD8Jl3mY8YaMcwQlS+uUDmXFY6L7dYMAC/xt5kcDHLduNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363472; c=relaxed/simple;
	bh=KDVlpvSPGRQwQHIvuNTYp3hQ6fScOFke+387t4yK93w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Du/q6G4YWhLPJrzDJ3Vo0WVrESVFtKxIT9cqozNON7JqlMfzIwlFQz55DlFpjNmjfYIjK/lhqUHNpVrvda72EJ/oRVxHQe+MZGWOV1chXYwYU2OOkjCIsdXAEr+ZRFLXFSiOg8ptcjjxgyVM3O7gDiXbdu8zmm59A189SUIvHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=rYKzFInG; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="rYKzFInG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=rYKzFInGW8/TIRRucFgfQQsWDavnoFAAjzrgW6/wZ9TdJkDbSUBRHyiCqKe9t5EAjN0nqgc6nUHlE
	 pQqmNGqIaLRuJnC6di6GOvBhDovCUcMjEnohcjnfY3QYU1of1pr6guohP/t/++9gd9GhgcZfk5fE8N
	 YhwfhLrJ84DLnoJ0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76ac60985d69-ac9a2;
	Wed, 07 Oct 2026 16:57:41 +0800 (CST)
X-RM-TRANSID:2ee76ac60985d69-ac9a2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03 (unknown[112.22.250.209])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26ac609747be-e442e;
	Wed, 07 Oct 2026 16:57:41 +0800 (CST)
X-RM-TRANSID:2ee26ac609747be-e442e
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
	Martin Varghese <martin.varghese@nokia.com>,
	Willem de Bruijn <willemb@google.com>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bareudp: set the inner protocol to the protocol of the packet
Date: Wed,  7 Oct 2026 08:49:28 +0800
Message-ID: <20261007004928.1268339-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <willemdebruijn.kernel.d7c5ac3be7fc@gmail.com>
References: <willemdebruijn.kernel.d7c5ac3be7fc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 03, 2026 at 15:01:48 -0400, Willem de Bruijn wrote:
> (not for this fix patch)
>
> optionally tools/testing/selftests/net/bareudp.sh could run a stream
> test besides/alongside the ping test, to exercise this path (with
> segmentation offload disabled).

Thanks for the review. I will extend bareudp.sh with a stream test
with segmentation offload disabled and send it to net-next once this
fix is there.

Thanks,
Haishuang


