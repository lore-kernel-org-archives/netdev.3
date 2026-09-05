Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801930C618
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 04:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788583515; cv=pass; b=ttJQ6rl9JCbGg1DsJphcpwNQtIi1Rrxua9SIdguXiOUNuKLl1iqvZlE8yAT05nhKdXkVpJOyU+uU1pbdwuXvtkI5lLH9SwUN6+TUkc3Ak3mL1RAP9Sd3nzFK+pnzI4uUW25zwxAyK0pw4MyWm4vmRqjpbSTIjb/M/SAqQxlYVno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788583515; c=relaxed/simple;
	bh=4yqcYdJFBXTkDgcH1FppejX8NHazc3ekZFlryNikycQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pd5c6L3kxGsfwlicH0iAgtPHHXtyiF8KXgyMtdzXhstvL1Sw7Dm4pDwcVEp2YKxBYO3bY0nMnmLKIms3YEy8UlGrKSu7Og2BkanfFYgwWPxS0KOjesoywItd1s/dJ+rY9l+vo810icr/CGQ1Z5D5NP2zIiIMPsSlZd5jORgUbs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjBuETiG; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjBuETiG"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-39b35105ba4so1081018a91.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 21:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788583514; cv=none;
        d=google.com; s=arc-20260327;
        b=coDSVDdkH7tqRAdYbKVv3SThgylEDyKQ9rbE3xgPgIEVrBPDwVZ4zBb+5S9pDsNnk5
         ccCB0gfBpeXQ3ksACqNLfBMD5I2pRvr7KWiH4OV38CvwL7f3HCQ+YuSYxEGh46Pe3jj7
         vpdWNPXtjSQLC0HzyEYG+Zyymud2jx8pcnnySXRMjJ5DnoFAqcHslyd2CmohcTmlvCcC
         Y/C3kAp5bGwCwQMjASfUBpxYe1to77cnFVVoXTcWo57vxQwSc7hQt9d3LLsYwnwNadr6
         +cHfpeSvd8tAK8LqaQJnxM4/Tfwdi6lSl2BRVd5k4WQuhbH9esG4IBOnfpIMNqXPOPRp
         zeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4yqcYdJFBXTkDgcH1FppejX8NHazc3ekZFlryNikycQ=;
        fh=isZHMaQIZE0KfD7Urr5+8Bcjb5phAJ/mojjF1qxXKYQ=;
        b=OhsTNOoQNKre8hUj5fmLBpQl7fLVPgZe3aUq2UG4kKZU7N+d5QolpihemrxjUqfBx7
         cTg+AqcO7amaK460e5Mdbe6OQzexVT3aD0lPdoKNMHyUPecQBrJ6TmHjNIXba7xbZFZb
         xoWDARrD8sLNj7hRar7a2DVkbODkk31yAMb9dpxTJT0/KDbIE4uKKWtF9OmpLepDNrd+
         02JBALCJZXnAM4J1MIGhdKrSPVeWNphDAExXz91WXa9QZV3l/roTRHDOUQpIuUi3wPlO
         yNownZcAfYUY2BN5OMGtYNznIuAwUN9WiEokOXZNI/En8A8p0PlFSVcgKr8rOKpEboEn
         uqMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788583514; x=1789188314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4yqcYdJFBXTkDgcH1FppejX8NHazc3ekZFlryNikycQ=;
        b=gjBuETiGdYgc2Hdv8dlval0soh98qUPNfkNtuTFb1yt+KHF5srMsUtONGlsjXj7UbA
         cE9sBamUVx34pdVizw0B0uwY7uFcXQjyrTOHPbBv/Ib5e+8f+LDC46M1zLkYB28nBM8g
         sDPW6JeP+dDMny6rXXqXylsEd3qyyZP2OmaDqpyg8bBKNtmDVyy6AEFogGr9/dL4erxp
         wGYtf3/uc7L9eNbcql8C+1rurOVcxHJhz2fj4+4OVRsSavFoCmsLvUwMvtGaNGp6CAoA
         f+s/881yj+YaQvnfai4e+YRrJMivO7uSKyZNl+mGhT5URU10JlIYGAiE239AKJZmlu7n
         aekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788583514; x=1789188314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4yqcYdJFBXTkDgcH1FppejX8NHazc3ekZFlryNikycQ=;
        b=cIM97OgqvUBIjZAaVOxOn8zODMLm9fsV7nlq8c9B/KSKr8lNbDluvRqKapBf9UpG5+
         IgwzGvopxryiYOF8vhgedMzOHVNDtmGveYfNxZEQnLLwi3fns2PfBAwO+Mixq3AikOWG
         GTimj4He/5mhx90tWOLpQZ+KAEgmugX05SjuME0GxCkJE6Eh+OOHAwsawXFAqwt7YVfm
         mmhxRChFhfLTqV2AE5YpFT+QwC+4qifqq+/YAwyxx6XH3lJv24WVVwULKm1IsHy9LQRX
         s3EWRVi617XbFiAw/TpcxV2TjTjOtbm27fCkyTEN8te9/loZIWjjeZeMj7lqNN3U2RRp
         0ROg==
X-Forwarded-Encrypted: i=1; AKwUvBwMR4mxM7Cx/rBbn5U/VxMsK2czZfxKipJjDd4t3QeH8H2YZqDCWuKpoMYPW6XOKpzcKwWUkYQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lhpEWTdnGh7fJz9ZOXzlxE3iQ9piuwmBmc3LmqNqwfyEpYnTMI
	Ol8AVNlQAR+1Io5iBGiAa+Wu97XW0KBtb3UhgM+5sHZCLjrpt54aLxNfWBR3kceFgF7KAu/zr8d
	f5dQ8nsn54LhaPISCnSA8gWG+zQZ+xnwiks8wtYzO
X-Gm-Gg: AYBFou0b09h3mITuJjcLRmcxp/vIK/JtTiMMz53GcEORjEi9zwx6+HPDVFnSMU2WBc6
	5O+/oV8zAYePCkV6I8xUqjbx33fgDHKO3HiYnIRjDlYnRax7If22HflwTbG2PQfsKoDy8MTW66h
	2xdAM/vfFP8L1GlIPNcKLJE4iKcA1q29Jvlo+p4C5+9SEaXXaOjhUI+deKj079zCOvsg3jyJJeS
	rTx5eMmoH8iiEMon3sN2H5Jp1QdvB//UKkD5YTau7sVcKY3PPYkooZC2S7HXptf0J6jfLojZbtf
	KMPGck3rkSZUcG3QXv8PRLxRKu4ZHLXcBRBUx+ZFE91IkluUA6OMDyHPR13bzTTT9URjHbquPYF
	NWFLbD4YXoOQUDbxjCrjns8sMLKVw12cOZhT8Wv3iKVo5DsIi2U34OMAMs61xG75Qm+GAYRDz7+
	Jezi9RuzXjxpdv
X-Received: by 2002:a17:90b:1d45:b0:398:9bd4:d1a with SMTP id
 98e67ed59e1d1-39b262995b8mr15126688a91.25.1788583513238; Fri, 04 Sep 2026
 21:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com> <20260903120840.1024153-10-edumazet@google.com>
In-Reply-To: <20260903120840.1024153-10-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 21:45:00 -0700
X-Gm-Features: AcwNN1VqnK2j-AHwh_YHGaGDO-jRWJkWS78MpZ23ZoVlIeFm__tz1Um3Kb8pBrQ
Message-ID: <CAAVpQUATfHtgPxq4Qhx=FvUr1A6kCet9kgkYoLvv1xx7byeJwg@mail.gmail.com>
Subject: Re: [PATCH net-next 9/9] vxlan: no longer rely on RTNL in vxlan_fill_info()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Now that vxlan->cfg is RCU-protected, we can update vxlan_fill_info()
> to run under RCU read lock instead of relying on RTNL.
>
> This completes the transition to RTNL-less link info dumping for VXLAN.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
