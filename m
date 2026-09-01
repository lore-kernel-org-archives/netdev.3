Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255A47ACC6;
	Tue,  1 Sep 2026 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256151; cv=pass; b=odg4xlTY26DwOsATQThcyLCZWC6yo6WdJs2qsz/rprjdYxlcKEcnQ9WiCMRsSwr4AjEV5ghfqCqbIBmofJiuPB6EvLSIeH9VDLDeKfhXivVsoH/zxVP+VEai0URAJaYTEV2all7hO13JFq0Iz+3j5XrqB3k2Fmmu4rJg9uUk+/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256151; c=relaxed/simple;
	bh=fdjq4JgtjxTCbbGpSjyVfqHS9wv2fi0/V43XMS8aY5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcbPYx7wpeJU1oKcy9dgXpETb7BLo6jva1v5wiE32USdRP8rNUoYPgr0TiPuvbXZ5Uu+5H/sMePUDdlRBTTnuxiDNjyYm6fuYEtQ/oxtyisRUd1G7NfyAfnlj9mtC9LwVceWX2JbKulQHy7piJnb306bEKAoU0lS/NN2stApaa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=F+e50YKL reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="F+e50YKL"
ARC-Seal: i=1; a=rsa-sha256; t=1788256123; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YOHNi78YRM/t8HPLjV6fyeyf0V6h/kcUQXLtKxtg05RO3CAPv3+jIwfWl9wqCu90aQD4MvIhFiVVPAxzip1S35VGM+H1JAeLhRyDKBarruRBccIfb+OOpmJs8XP7vVn0rRzNqqBXuzsIMVIfvFqtGOpyuwDNfVzH/ez0/1SXHx8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788256123; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xgfL2ZxvWYtuSOuc5uHfLGmi/omsRkG2iq0XXnd0ZG4=; 
	b=bbX4gIYqhRHnqNhINXNpTLFbiNn9i4aKJ3KDTK+FyMscjRkDcLXcmvi9WBpKxCZpL9C56kNhovAp4f5m19tvgcsypx89ceTJ6oRwXmtOxE0QuDtSY8EOETcLuAYvI42sQJuPiqPl06P+rkSPInmRbMmzA9NHA+wmvqPduYDtZ4k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788256123;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xgfL2ZxvWYtuSOuc5uHfLGmi/omsRkG2iq0XXnd0ZG4=;
	b=F+e50YKLvFO+Y0WVEHJZCTLhqYo1/oFkCEKIEMjwA1ntF3u6NSKSqC7ctHWdn/XQ
	H2b7O6/rsJPA7TmdMDQlSkrpv8nwQEmSEsASCnKNKLs8YKMjuRHV6h60OKzgnuRcSsN
	5JKXxA7k62aMZ2Ugf2/ojZ3W1hgKWcFnvoHbDLaI=
Received: by mx.zohomail.com with SMTPS id 1788256120619666.0056640472026;
	Tue, 1 Sep 2026 02:48:40 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: idosch@nvidia.com
Cc: AutonomousCodeSecurity@microsoft.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petrm@nvidia.com,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu,
	janak@mpiric.us,
	shardul.b@mpiricsoftware.com,
	kalpanjani009@gmail.com
Subject: Re: [PATCH net] nexthop: initialize extack in nh_res_bucket_migrate()
Date: Tue,  1 Sep 2026 15:18:27 +0530
Message-ID: <20260901094827.1236039-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714104428.GA838500@shredder>
References: <20260714104428.GA838500@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On Tue, Jul 14, 2026 at 01:44:28PM +0300, Ido Schimmel wrote:
> remove_nh_grp_entry() also doesn't initialize extack, but
> call_nexthop_notifiers() is using NL_SET_ERR_MSG(). Still, the same
> problem can happen if a listener is returning an error without setting
> extack. Please send a separate patch (targeted at net-next, no Fixes
> tag) to make remove_nh_grp_entry() consistent with
> nh_res_bucket_migrate().

Hi Ido,

Noticed this hasn't been picked up yet - happy to send that patch if
nobody else is already on it. Will target net-next, no Fixes tag, and
keep it consistent with your fix above.

Thanks,
Kalpan Jani 
