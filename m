Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10429A32D
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625992; cv=none; b=G0m+IDAqvO5mLwUhFPYnmhXdsDnfFuzAtOLZhrPDSd5Aekd8cYKqzg+ocIxlSyy6s0xoD2h07g2uAltUxRCPpdN1DrFkC1kKC9i7BAAyaPXoVdSjGOp7qLmCyeZ5hLYJuuR1uAckUNrwaMM09q8Col1/eDhUlmC2aSxkyV4+u8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625992; c=relaxed/simple;
	bh=TRzTq0GwbPZ/PdEq+U09xb7pJmp5jBiucbPCQ/6q9GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNs2WzL2iXdFiFUd/arQNn+jrD/yexbJqCCvD969yyOWmsSm737BedgUiNNm5QPDcsmaQd8/NVx6w12hO/aOyp0pmc1T21ncgW4ahac9I1P4L0uTA/vXUuC1VIi/sBG6pmtkDdQBdjCT55y3Lh75sHrrDanlwDdNw8YugIoqITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=gRkYV2Dc; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WOKsP7g4; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="gRkYV2Dc";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WOKsP7g4"
DKIM-Signature: a=rsa-sha256; b=gRkYV2DclE8/X2HFxYmhQ0tvmrvZIL6pnqmPYsIgPyg6LsGfuJCGn9AXX0G32AMnnpQHVcM5oatay6JGeSM0yEW5EDxWeviSDx+8SntzwGsQoURoMp30NbUw6qR8QIpPx58gM8xTLnkt7wMrfMNT13gqk3uAEmW2KgWpnJUp4J/081VWy9pCaNsJz+Ghyo009LkWdP8Cd+UEUmvIPAxs3M682MDlQMHMkBFlIcI86g36S8JT36CjTuQ+yCEsuNSMuiGgOE2BvLXDrkINICjgtJ7b7Jmrq0kTIKUCpDprgG+2b6ivkNTtjecPMDLiGxHDpkZ8EuADjRR0mCqp0qOusw==; s=purelymail1; d=tinyisr.com; v=1; bh=TRzTq0GwbPZ/PdEq+U09xb7pJmp5jBiucbPCQ/6q9GQ=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=WOKsP7g411YQDxCZwuSWT1oGZHPhcdFsalhp139Ipmp+KhLXzLL3UNf6atfdW6X3zUxul4rUuGxcKEIZPOYZ/1UPKR/HHdL7uRKxQ2RLgMpRxSvtz1lo2lFBZFUGE71tWu9L3jKV6NH6j32uuJ6t109iT9zTLy7g4DBvH9oIZ+EEFF3YRQJ9R/48zarWuLB4z1rUsaUuzGdn/7rUuRWjNYVBO1zmKWwTljPRVPcGvVsVgwdhl5OMEPWnqHCjot4W6cSgatIqF0rCkNS8L7rE4WXwvcPre83gWvPdTRLIgHZvRWgs2267ODygrA/NI7lPJGwIhj9Cys9kbwm8oWw7sg==; s=purelymail1; d=purelymail.com; v=1; bh=TRzTq0GwbPZ/PdEq+U09xb7pJmp5jBiucbPCQ/6q9GQ=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 929034348;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 27 Mar 2026 15:39:44 +0000 (UTC)
Date: Fri, 27 Mar 2026 17:39:32 +0200
From: Joris Vaisvila <joey@tinyisr.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next 4/4] net: dsa: initial support for MT7628
 embedded switch
Message-ID: <acaj0K1EevnhU-Bw@archlinux>
References: <20260326204413.3317584-1-joey@tinyisr.com>
 <20260326204413.3317584-5-joey@tinyisr.com>
 <e6d91e11-fe19-48c0-886f-e1c0c92b094d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6d91e11-fe19-48c0-886f-e1c0c92b094d@lunn.ch>

Thanks for the review, will fix all of these in v2. 
