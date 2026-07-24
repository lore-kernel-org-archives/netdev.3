Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7C3F482D
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931223; cv=none; b=RmkNfyOjAO+jsYUQfx5Avn0qvGpPWZpBq9sGRvLBZaSGrDVYR7GHjBM6awoyWVTJD/zDSXf/IxBn4MECINasAfJ710CaOU1jRqVtm60Dl8E+8np72TiFp7VuFB4Mc2rvKj3ePwDuIKxfXqR40KXi1+0XTeDqwFpwAmTbHQ5BWs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931223; c=relaxed/simple;
	bh=pMKpKubFx9kEgDbednVOQ47WZM90zaPgp5ftx3GTfMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIx7ou78pdie0IpI/es0Jw9Vd8T+nj82oGqSGawzMWxYfUk20mi+T6pX170YYWiAdV6eD4rUIct6oajX+vaN8aqHS+Y+BAiX/0gMTW7eKzaC6cs93Wd+cMRXSQFEinozRCZtjrnolFD6jUQPSzUr8mZhsczfEG2GqtKEramd8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/uu45oP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/uu45oP"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8486672f03cso909409b3a.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784931222; x=1785536022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z2sozbBNB86MDdVFB0IAFAWmkqaPuc9KNZQmr6UjhYE=;
        b=N/uu45oPkIawysFLAkQk6ltaKaCSqLTnkBhZBgm/UfB4EtlWngLPRwQbPVc4UdH6QS
         NW4ozGhV1D1K2ggsNsXTCSQ9NLjWIhQXIh0uyGoSVuHWS76jTo8jWsTug5As4xCxuJ07
         lFjT1j5tKoaIr9Iasx5scXnqPuDFkqjDVB/2o642YFIEPDjV/HDjnMKjHD52WxXIBxIP
         owgmo1iBP+NHHWXAVrvKMzVGDxW1IRwHWKyjginBqM4FESBmSV5JmEYdVkNfDN11hCUN
         fiy1QQeaT+5hlnweTVfEtxiMERK54bc9gz+Kymb2EQ1LSwRjp4L83nxkUn4q9VlgTXcB
         s3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784931222; x=1785536022;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z2sozbBNB86MDdVFB0IAFAWmkqaPuc9KNZQmr6UjhYE=;
        b=AYEzd2QhJS046TVb6YQMol3yZ8+EfFAhgBHr7VbwJ56bOuiG/Ef0eq8WBL++kNpBh1
         UNvP1NiX2zazOx7tbRk3FMvD1MvvUJXDsom4D/WIT8X2zIj8wvRt9hfq+rVcj8O4qvg2
         FDXETMjv8PTf6Eq9PIv8NVAqiChAgdqdKmCCigAp7iFicyf2nxozEG4Q8krsOIW4uJlV
         5N2zU78XBXDTIEkXZOqzt6lT01Sua5z/I1ENmOD9VhVRX9Qra283IUvjYTMlWcMfAXLF
         UQY6nGtYD4/gjg1QmyZHU/DNSbxktqY25EqSGfYNTiksBdn3eyM2ClYFd+caK7B+iCJH
         T2dA==
X-Forwarded-Encrypted: i=1; AHgh+RrcTk32h0lRyVrqNgIqiTp/eGszhAhK4co++lzcqveAVNdg8XsrFdesOUaMT59rFXc8jIB0ELA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXjLGF72s7M2nIqxoE7yjmhjEqLBxS84a4BA5oUzQqVnXC/Yc4
	Ex0jwS3yC+Ft2H/co3QhBWak+RQiNAvLd6ehSGMe6PkjATtgRHxdND5P
X-Gm-Gg: AR+sD13OAN6AisweKHWaAW2c5/rsvEe9M0CMXDKxJnSD+tkbs9ajP0ZntpItU3pt7va
	ZMj9QMGxqteBK9FDmXmnEVnWblZmV4Y/rp84XKZr4IqCxwUk5rGQtzL08v4pd/rY+6fi/UXrTQ7
	hNVbgl5xfA/Xk9l1CYimkZAxs9maHssHfoSOiq6S0bB5EPSElmNUXEH0XCDdMpesgFdNDNFfMaD
	r3Jc6UjRQ/we9XlL1iY1Y+7Z9vDe1Is+BrsSfPfRrmMQqKm0O0053gWZtk3LXhPUDtq9JCbKJnt
	3/F65L6bzb3wI3B5eKDS1yoeBAnN3fUIQQ3Pv+RGfszKEw1tBMV7e6DdqP4cRkwl32hzuo30Tzg
	4ES1YVJOOMLEyKJ6YCu72RxUhVk4cPR+N0b+I0nyvC0Eymp6Hq/XjWkP5vtRHAlwSUX8sJB6V91
	XBO7OUvfY7WotXGwA74E/DzkPdBWLZW1AcPX8MDKrRyR73Q+97CZcgxEIDT5ioPujisfuuhFqZ3
	9tBpMpX038=
X-Received: by 2002:a05:6a00:982:b0:848:6720:6fee with SMTP id d2e1a72fcca58-84e59544f08mr53110b3a.40.1784931221615;
        Fri, 24 Jul 2026 15:13:41 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm443138b3a.58.2026.07.24.15.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 15:13:40 -0700 (PDT)
Date: Fri, 24 Jul 2026 15:13:37 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, sdf@fomichev.me,
	razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
	matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
	Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <amPjkerd2duU2DH4@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
 <20260721110903.34840531@kernel.org>
 <amPTWGX/3LHepYR3@devvm29614.prn0.facebook.com>
 <20260724143001.5afa8631@kernel.org>
 <amPbqtxPdhs9QrVP@devvm7509.cco0.facebook.com>
 <20260724150716.07c49ad8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724150716.07c49ad8@kernel.org>

On Fri, Jul 24, 2026 at 03:07:16PM -0700, Jakub Kicinski wrote:
> On Fri, 24 Jul 2026 14:41:47 -0700 Stanislav Fomichev wrote:
> > > > Talked to Stan and he mentioned the original idea was not necessarily
> > > > just for link down, but any test that could be considered disruptive to
> > > > other tests, with the idea to eventually introduce some scheduling
> > > > (postpone disruptive until the end).  
> > > 
> > > Perhaps have such conversations on the list? IDK what Stan has in mind.  
> > 
> > I don't have much to add so I didn't post on the list. In my mind, disruptive
> > started as "anything that can lead to a soft reset". But since the
> > sockets tend to survive these well, I do agree that your definition
> > of "link goes down" is a better fit.
> 
> My recollection was basically that the test is not safe to run over
> SSH (without tmux). Hence the link down concern. If we say soft reset
> that'd cover 95% of the tests so it's not very useful.
> 
> The existing doc and README already document the link down AFAICT.

Indeed, so I'll just test and confirm if devmem's existing
ksft_disruptive tests do or can cause link down, and submit a patch
removing for those that don't.
