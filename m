Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792562538;
	b=MWuuOQHFPbdMKjVa64+EWHUSLRy8YmynupO2IIFOvSTSZu5mj4L810O7NmwibsaXK8gX
	 I4B50bGwrR3X4pQTsVHk4xsp5LA13whNZeHYSXBLBFA5//Ccg7HlyRGtNV39usYUpX7Rs
	 5TIZOGQfq9dZo/RoakKuoWp7mtVrF+Ypkqr8xBqh+3Z6iSN2TX5SK10rLnYz6zkCzZKoh
	 yk230MgRuzZ09wpk7ryDiyjMleypN2EmciubaiW4P2s2iTIB9W1TaTpNjGa3RRtWyRFL9
	 AalL98ZjTFrJwN6rA5rwCZ9eqrF59BsIOd/JtVs/Z2SNDfQ+mTB9rAYR6svCOd/eFFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562538;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=y/I63NghyTS+d7LjacRX5YLKjSXzjG7oxUqATOrhyZo=;
	b=z7unJhv6JyCd/UXcs+JwNHecN+h2XAvXfS0oDR7z8OJ9DtmfuchdxXl8tVQ8f+RWG2ro
	 4gsTX2KwIDi8y3G3ZJESTHm9lISrKgzOQFDCHCkc4zDxFPNqqIODCjyEv1pkwG6iC5poB
	 t2uBGx7zZhQMX0hi6O+C4PJoTzo7EFrbok7kgwEzS+LsVYtKU4O2UcI5HdVZRH2MSO14L
	 rv8HHMLb1Echba3ZL5eK70k7SXRNJQfm7hqbmDHGd2kQIaYiq5wlm43EfPE2gQLUQxVQl
	 C7w7oTeo5D5KXkuB6hYOKm/499Snw7JTCuEngJsKgxRwUPQSIOOWioNdMdpsLeVUacg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=b4PfZeNV;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2259E606A319;
	Wed, 21 Oct 2026 06:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2259E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=b4PfZeNV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=b4PfZeNVjxspmSSyIu9QTOPu83tLekpcTMbOy9bI3Ndf7/lQkXM/Pk4oHyn2yXBcqyJfz6EZT8MpN
	 IOy0sotX0vsw+HCND+WHcbWibfEh7F2vssZhepdbj6aPEKOrg7W8C4OSd9mPuzdqbMrTqjUNVE2T36
	 rCYv0OxuRNO01moY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16ad85561c6f-fe274;
	Wed, 21 Oct 2026 14:02:09 +0800 (CST)
X-RM-TRANSID:2ee16ad85561c6f-fe274
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03 (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26ad855581c6-e8248;
	Wed, 21 Oct 2026 14:02:09 +0800 (CST)
X-RM-TRANSID:2ee26ad855581c6-e8248
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	William Tu <u9012063@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] erspan: skip the platform specific sub-header of ERSPAN type III
Date: Wed, 21 Oct 2026 14:01:59 +0800
Message-ID: <20261021060159.2810516-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020171623.GB3236673@shredder>
References: <20261020171623.GB3236673@shredder>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 20, 2026 at 08:16:23PM +0300, Ido Schimmel wrote:
> The cover letter says this was tested with hand-built packets. Do you
> have a device that actually sends the sub-header? If not, then I don't
> see a reason to add more dead code to this driver which nobody seems to
> care about given the lack of reviews.

No, I don't have such a device, it only came from reading the draft.
I will drop this patch and only resend the first one.

pw-bot: cr


