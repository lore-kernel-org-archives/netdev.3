Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF2305691;
	Tue,  4 Aug 2026 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878756; cv=none; b=sv8spQ7q/UB9KpeS7rcbk/4dM4nL+NK232HhIU+f4yfi2Vk2IEl+09aBSQ7ENEjSyOgxgxp4wyi8HSu4m/2VQh3QQ/YiD114XpqIhCQyLbOahYQdI5fi4wCm+wz4YDTJvDD1Oinhq1fZs/7EZ0zWTys38QlfhOWHKjKSCa7EMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878756; c=relaxed/simple;
	bh=xyOdhxzWnQiFkS11SfI1QDBsvLBCN/T02pS7RGWQFAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cw6EmkN9ozy/HclCzBsV59A56R4hSHIle3n60DIuYDh+j2+0eGPKBQ7movD37PurqF7zyeF4YCVziE1LkgOrenYq/mm7YJUJE6Y2qE4IR1a3ylF11zWCPULwvX8wjDlIgfdbTueQ4lICdb9BIjSor6V0Qc/OUUHj/tPL1Wxz+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oy3a+slK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy3a+slK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8A51F000E9;
	Tue,  4 Aug 2026 21:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785878755;
	bh=JSJ8cuBfx1QfxUySXJCZeVl/NB4WhTxNOyDVJz5zRhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oy3a+slK03f4AJBonKYTMWRtG/CSSGhRtGU8EvQwH6diMD/P8z3YI7Aa3J0bju89F
	 b7FMcockNB35OPbmNljsFDiotKHS8BADnz7KRSl2NRLc904CiUWaCnY/SynwAN8qrK
	 gOiMhEQ0BMykVst+TVZ80oGWyBa6DQ27hkS9aNEsVXe+vuTmmJgumrUJUnU9MVARZ0
	 FfeVBkvbmHQcX32tloK8Ws/cKZUdiaZ7Oh18eDDYTG5KIsA1TGsJiNZ+QmeUX3x97b
	 0kiYt6eQSfTFSuGdLupXhel4xYGuZNhIbpoOExkK1WmOLBYwoLvbijObCAp+IdOvqM
	 EhY3SdYqUVZuQ==
Date: Tue, 4 Aug 2026 14:25:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thaison Phan <thaisonphan@google.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S . Miller "
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Fengyuan Gong
 <gfengyuan@google.com>, Stan Iliev <stani@google.com>, "=?UTF-8?B?QXNi?=
 =?UTF-8?B?asO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=" <ast@fiberby.net>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] tools: ynl: check for null ptr on dump
 free
Message-ID: <20260804142553.6a67fff0@kernel.org>
In-Reply-To: <20260803201652.2752685-2-thaisonphan@google.com>
References: <20260803201652.2752685-1-thaisonphan@google.com>
	<20260803201652.2752685-2-thaisonphan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 20:16:51 +0000 Thaison Phan wrote:
> Static analysis

What's the tool? I guess we can do this but I'd factor it out to 
a separate check at the start of the function. Otherwise it reads
as if there could be a NULL on the list itself.

FWIW NULL is not an empty list, it's a dump error. So the static
tool / LLM is definitely wrong. But I guess free(NULL) is supposed
to be a noop in general so whatever.
