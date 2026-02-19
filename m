Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38CC29A1
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771466172; cv=none; b=RRlviCF5/O7BGzwZ5SadF0LQeq9tC2bKFSfqxml/9i+IgY1LfaBEY2RTiT8mx0JwVfMP8nbyMofD/pm4ZpbGRbUHW7i+VQXOlwFOThlsBJrMXZonPp62cxKZz/1Y20Q3zvz7fDtQNco5axQaBNU1rtALn+6kU/Rg4CIw8zMMEpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771466172; c=relaxed/simple;
	bh=1Zr6zn+t9zQ5uzbiKux522mMCUA2Rat4glkGMdEmA08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpuwBvswr3TdIbL1ebYcJrwLbcK/uVRd9iLRZGQFclNytBbqQ6s4xqr72Gk/5YlasgS4TNDavYmAgm2BwF+fqbRmoU5aaHuh92t3LNTrFmtvA+W/M+x4I9mmYy475QQlOhl3vV94Fzyt5uMIKnrnDV679JCyHpMvIcI1N4pCLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9ZlxRlv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9ZlxRlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1546FC116D0;
	Thu, 19 Feb 2026 01:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771466172;
	bh=1Zr6zn+t9zQ5uzbiKux522mMCUA2Rat4glkGMdEmA08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L9ZlxRlvz0gAOZGndoAcQUAbNGoc5Q9zhtBuFJkAIHxh1L1Jv/FBiFF76MfUQM3Aw
	 89I3FUKMAr5o5rDoqEo0Yq42gqco77Ar949v8QnSr3QAXQ+sIf5BO3xYo7vi68m4Ob
	 DIA1HnzeGlYbeoO1VzQT1DJi74bXc5IOiUVjK9n0K9Yu8JzpKRMA1uRpxbuHb8bWJw
	 r4hT94HN4u7ObB2Q20El1jUv3Nhhh4mlwpEE3L41SEu/cbx3k37o5ifGShwMgkdiF9
	 pBOrIO7mrMujacO8qaL+4x4dRz97BjHA1KiPiJ0dXLSnOoIInkMuz3pqurNraYt9Y8
	 oX8g2cD/+st+g==
Date: Wed, 18 Feb 2026 17:56:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 aravind.iddamsetty@linux.intel.com, anshuman.gupta@intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 raag.jadav@intel.com, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v7 1/5] drm/ras: Introduce the DRM RAS infrastructure
 over generic netlink
Message-ID: <20260218175607.711ffd2c@kernel.org>
In-Reply-To: <20260218121904.157295-8-riana.tauro@intel.com>
References: <20260218121904.157295-7-riana.tauro@intel.com>
	<20260218121904.157295-8-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Feb 2026 17:49:03 +0530 Riana Tauro wrote:
> +    -
> +      name: get-error-counters
> +      doc: >-
> +           Retrieve the full list of error counters for a given node.
> +           The response include the id, the name, and even the current
> +           value of each counter.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      dump:
> +        request:
> +          attributes:
> +            - node-id
> +        reply:
> +          attributes:
> +            - error-id
> +            - error-name
> +            - error-value
> +    -
> +      name: query-error-counter
> +      doc: >-
> +           Query the information of a specific error counter for a given node.
> +           Users must provide the node ID and the error counter ID.
> +           The response contains the id, the name, and the current value
> +           of the counter.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - node-id
> +            - error-id
> +        reply:
> +          attributes:
> +            - error-id
> +            - error-name
> +            - error-value

The get-error-counters vs query-error-counter is sort of asking to be a
do and dump of the same op doesn't it? The return messages are the same,
one returns a single counter, the other one (filtered to given node-id)
dump of counters. Not a big deal, but from Netlink perspective having
these as do / dump of the same op would be more natural.

On top of that please definitely make sure that the code is generated
with the latest tooling from Linus's tree! We tweaked the output a
little, it shouldn't happen again but running regen with this commit
gives me a dirty tree with a bunch of:

diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 3415ba345ac8..31f0180c1035 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*     Documentation/netlink/specs/drm_ras.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_DRM_RAS_H
 #define _UAPI_LINUX_DRM_RAS_H


Last but not least:

$ yamllint Documentation/netlink/specs/drm_ras.yaml
Documentation/netlink/specs/drm_ras.yaml
  59:14     error    too many spaces after colon  (colons)

