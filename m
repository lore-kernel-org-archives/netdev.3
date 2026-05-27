Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2503B27E1;
	Wed, 27 May 2026 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911368; cv=none; b=DJ6EY1hSGrF6P4OmY9CzpO/bRPYEn5ySOtiRYFQS1tV2cJW61tjdPAF8cN841BGg2XH94l1Trjr9kRi2E+WuOBGBdkTLsxPdmmRWlaZYyh+d5X0LKsngmHtyXgHeLjEacLvjFlMcg0mfmuP4aqMyG5n7cIJaxTBcNvZq006G0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911368; c=relaxed/simple;
	bh=v89s4B1mqSIf7j//EsoDnuERwexrjSyciuIsRlFS/xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skEI72SaELWSPYCI+NPEh5JjlioDNPXYvRH0XtuiX9aQ7RdwgnsYC1dlmHqvEpujNGtejzH/tLiUpfCR+53zHhbKcb6t9sYxm40uKZqqSiWJo3R//Q+vXeJMYZq2QSWuACixfuyW0sI8Bx3NqMohk71sGi3uCNlwmJbXpHSsGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvCqghQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvCqghQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFF41F00A3F;
	Wed, 27 May 2026 19:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911367;
	bh=v89s4B1mqSIf7j//EsoDnuERwexrjSyciuIsRlFS/xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvCqghQMHRVW2hLo8U7oG35uTKb7pGf4HgMYFO4CLfyRpONvk8kegNlXUxt8vxK12
	 lz8RXyXppTdz4AQrFfntCJ9e0f0RbPKFbZWX2chntIyF4NbNys4Yak3p9FHbagjXKl
	 K06cPAoGerUTHfN2L54VPAeIiEtVPkIjv11wAtG/neAih4tWf7aIxvb/iaIWtOkXNl
	 qAYE7nyRULs0oXPdTF6QE6uAJ+6V2Yj/34eA14lJlTGaRxrb21s6oyOE1gPj7PgA5G
	 aA/9/+5tWiLZwvVHqD+Bg6vr0xWfNZ7coI3xxydnp79Wga7JVj0+Q7n8jw7NGSQbQ2
	 Cpo+IIcwojNmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	jianbol@nvidia.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>,
	Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: Re: [PATCH 6.12] net/mlx5e: Use ip6_dst_lookup instead of ipv6_dst_lookup_flow for MAC init
Date: Wed, 27 May 2026 15:49:03 -0400
Message-ID: <20260527-agent5-item011-mlx5e-ip6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526192214.78312-1-gyokhan@amazon.de>
References: <20260526192214.78312-1-gyokhan@amazon.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit e35d7da8dd9e55b37c3e8ab548f6793af0c2ab49 upstream.

Queued for 6.12.y, thanks.

--
Thanks,
Sasha
