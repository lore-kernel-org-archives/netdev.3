Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8AA3019A9
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786322573; cv=none; b=NxR88rJ/OXp5RMIeWHxYFvGWy3ruqRTTFSECRD7whN8OqQLM+UvGl76WYqkDKSnd40EL96brcAO7EHEn6ZzPl0rBPusrikWKQYr2bDxhDZp1NNLY16/yveKpAjFkpJcq5ejVP3vCJfU/tzaQQZQH6Jn1Pic9FNQpRNGaA66BBNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786322573; c=relaxed/simple;
	bh=Uu9cXR338rdy30ZRXOdsY5Z1AVp2/3KzS6fyp1KuLhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZLM/S6QAPeqmGPNUmBRbRTBB+ZBfWgVIrJaZIsQo/Of1FgNSV3+W7X8lX2jPt7PJiJDlyOaHCsXfiEWfNW+eeDIFugSJRISB4SEVjiF1BfuYfzk3YxJrWOxc3N/yoF555F5mbatXQAOt1tG7Tg6FGnaBaDU1EWfmXnzfgTIRD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODFUaDRG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODFUaDRG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786322571; x=1817858571;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Uu9cXR338rdy30ZRXOdsY5Z1AVp2/3KzS6fyp1KuLhQ=;
  b=ODFUaDRGdZAfXBnL+5H9pNreNAYjY10I02/itUS5O7v/q7VVsHSAN95t
   l7UttdSj2PWRVahBxKfLAxf7V+n712xF0UcSFGh2hqj24n8lEIKpnQ79J
   Y7cRBrKUBzDmKdjsVhimsS0H4pE3FBD1CAlqZvVKz4BFjnkx/JoRh5+Kd
   KvQ4HQ1kipsJtEwY0kctAz+QNJvtecv65YRqFWB/OkTttTN+FFDGURDpC
   1uOp5XN5LRURKdQ0wCce3pjV7v262W9PsHjIGjuToRfJgzd8XiWgrW79E
   Dopbffsiy1bwJI7YlxFvn84/yAvGkOvpm5Tu+jHomB7XhjRrAMLfNZuLt
   Q==;
X-CSE-ConnectionGUID: PhEqGwDDSFqo3GnzTMxoxQ==
X-CSE-MsgGUID: hU+8Hi9TScul7QT+e3V0HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86859585"
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; 
   d="scan'208";a="86859585"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 17:42:51 -0700
X-CSE-ConnectionGUID: zCArvC6zT+WmkAtNem9i7A==
X-CSE-MsgGUID: PJrMC+LASsGPI4+ZajEN+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; 
   d="scan'208";a="262943554"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 Aug 2026 17:42:49 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wtE6I-00000000MU6-2GCj;
	Mon, 10 Aug 2026 00:42:46 +0000
Date: Mon, 10 Aug 2026 08:41:47 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?Q?"J=C3=A9r=C3=A9my?= Jean" <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Subject: [net:main 2/4] net/sctp/auth.c:412
 sctp_auth_verify_cookie_params() warn: always true condition '(random->type
 != (-32766)) => (0-u16max != (-32766))'
Message-ID: <202608100747.D0iwjzi5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git main
head:   dd057113ac7ba5bdd2aed3d9405305911152f911
commit: 3dbb44d88b1e94dd31fe43588af7437b34b44d56 [2/4] sctp: validate cookie AUTH state before use
config: arm-randconfig-r071-20260809 (https://download.01.org/0day-ci/archive/20260810/202608100747.D0iwjzi5-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
smatch: v0.5.0-9187-g5189e3fb

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608100747.D0iwjzi5-lkp@intel.com/

New smatch warnings:
net/sctp/auth.c:412 sctp_auth_verify_cookie_params() warn: always true condition '(random->type != (-32766)) => (0-u16max != (-32766))'
net/sctp/auth.c:418 sctp_auth_verify_cookie_params() warn: always true condition '(hmacs->param_hdr.type != (-32764)) => (0-u16max != (-32764))'
net/sctp/auth.c:441 sctp_auth_verify_cookie_params() warn: always true condition '(chunks->param_hdr.type != (-32765)) => (0-u16max != (-32765))'

Old smatch warnings:
net/sctp/auth.c:1018 sctp_auth_init() warn: assigning (-32764) to unsigned variable 'auth_hmacs->param_hdr.type'
net/sctp/auth.c:1033 sctp_auth_init() warn: assigning (-32765) to unsigned variable 'auth_chunks->param_hdr.type'

vim +412 net/sctp/auth.c

   392	
   393	/* Verify AUTH parameters copied from a state cookie before they are restored
   394	 * into an association.  When cookie authentication is disabled these fields
   395	 * are peer-controlled, so they must satisfy the same constraints as locally
   396	 * generated AUTH parameters.
   397	 */
   398	bool sctp_auth_verify_cookie_params(const struct sctp_endpoint *ep,
   399					    const struct sctp_cookie *cookie)
   400	{
   401		const struct sctp_paramhdr *random;
   402		const struct sctp_hmac_algo_param *hmacs;
   403		const struct sctp_chunks_param *chunks;
   404		u16 hmacs_len, chunks_len;
   405		u16 n_hmacs, n_chunks, i;
   406		bool has_sha1 = false;
   407	
   408		if (sctp_sk(ep->base.sk)->cookie_auth_enable || !ep->auth_enable)
   409			return true;
   410	
   411		random = (const struct sctp_paramhdr *)cookie->auth_random;
 > 412		if (random->type != SCTP_PARAM_RANDOM ||
   413		    ntohs(random->length) != sizeof(*random) + SCTP_AUTH_RANDOM_LENGTH)
   414			return false;
   415	
   416		hmacs = (const struct sctp_hmac_algo_param *)cookie->auth_hmacs;
   417		hmacs_len = ntohs(hmacs->param_hdr.length);
 > 418		if (hmacs->param_hdr.type != SCTP_PARAM_HMAC_ALGO ||
   419		    hmacs_len < sizeof(struct sctp_paramhdr) +
   420				sizeof(hmacs->hmac_ids[0]) ||
   421		    hmacs_len > sizeof(cookie->auth_hmacs) ||
   422		    (hmacs_len - sizeof(struct sctp_paramhdr)) %
   423				sizeof(hmacs->hmac_ids[0]))
   424			return false;
   425	
   426		n_hmacs = (hmacs_len - sizeof(struct sctp_paramhdr)) /
   427			  sizeof(hmacs->hmac_ids[0]);
   428		for (i = 0; i < n_hmacs; i++) {
   429			u16 hmac_id = ntohs(hmacs->hmac_ids[i]);
   430	
   431			if (!sctp_hmac_supported(hmac_id))
   432				return false;
   433			if (hmac_id == SCTP_AUTH_HMAC_ID_SHA1)
   434				has_sha1 = true;
   435		}
   436		if (!has_sha1)
   437			return false;
   438	
   439		chunks = (const struct sctp_chunks_param *)cookie->auth_chunks;
   440		chunks_len = ntohs(chunks->param_hdr.length);
 > 441		if (chunks->param_hdr.type != SCTP_PARAM_CHUNKS ||
   442		    chunks_len < sizeof(struct sctp_paramhdr) ||
   443		    chunks_len > sizeof(cookie->auth_chunks))
   444			return false;
   445	
   446		n_chunks = chunks_len - sizeof(struct sctp_paramhdr);
   447		for (i = 0; i < n_chunks; i++) {
   448			if (sctp_auth_chunk_id_forbidden(chunks->chunks[i]))
   449				return false;
   450		}
   451	
   452		return true;
   453	}
   454	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
