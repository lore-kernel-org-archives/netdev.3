Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920460;
	b=iZ7mhRpbZdeaMOudwMOZtYXWYU2cQDcuDIsS0OwPpAC/qFUEk4kOombO5SGEv/CZqRor
	 r8W4qrUTVcNu4yeYsYXXDaYpidgjbZvspI38NrrfEDcX8Kx5EqwfTLUgT5tm3OJ5xUGAC
	 DfDmHwdzEQJiFOzV6q1tyxqOLKE9KY4/5KNO/3LLFQBh+geUvLH0jqIGCeQBdsGOP8T7b
	 XFNWrqYTaDXpO3wqM/0uo7yTOEudbjLgvE3fQLrMkU95MUQxb1HkH2ZqTrIrE0WWDoufd
	 5rFdNTeyRczmhEf6iDMnnLEeNQb8Jt4n9cMTF92S5sjh3RMTaS3X9J0YqGdckFl8crA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920460;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=/vuh5OOQdZeMFaVGWa5G1rUhjqyMGz1Nc8qVuRkCHdw=;
	b=XizJT+/IHkC+cHzsFslUvUuHvl4lxZqwS+NMuo1Bnx0B4Er1VTxONK7w7MpsuEzLTjUk
	 ImFpk1CMdHlmPRgyiPwDwn5YKezEA929dCXSIUXi40Fz1wSrlXTQc8pfKSoWb6unkUXHh
	 pAf2tf6940XnZEynn3I9YePSxjCy28auMLPEltskvH/LbMKjZ7G7QhH1IeXvQaekH+g90
	 H0tKSp0gWvsJHsskuEYFaPAO45GgZ6/29mwGnPCi0/jIFlnJDVJyN9HKSUQqYbRzP0ZVf
	 2PU67vaEh2WUKAnwtU+JjvwqFh5vqSxCNkuFLkMaKqe2E0AIU2xrFA0/uv3sbTmnQiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CBE606A333;
	Thu,  5 Nov 2026 23:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82CBE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A32BC92009E; Fri,  6 Nov 2026 00:14:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9C1F592009C;
	Thu,  5 Nov 2026 23:14:17 +0000 (GMT)
Date: Thu, 5 Nov 2026 23:14:17 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3]: net: sb1250-mac: ethtool link updates
In-Reply-To: <20261105193435.2050321-1-f.fainelli@gmail.com>
Message-ID: <alpine.DEB.2.21.2611052112280.6502@angie.orcam.me.uk>
References: <20261105193435.2050321-1-f.fainelli@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 5 Nov 2026, Florian Fainelli wrote:

> This patch series addresses a few minor issues:

 Thank you for doing this work.

 I ran minimal testing by booting my SWARM system with the changes applied 
which runs NFS-rooted over one of the sb1250-mac interfaces, so the driver 
gets exercised, and I have acked the individual patches separately now.

  Maciej
