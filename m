Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3516486BA7
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006583; cv=none; b=Zjp2xkRAsfbXZwRZLtukOIqhuq61ixlMrznjT15U2uSB8mOiz1kSSZ27D0nP0LghMAePR2weEg+MU0aOD7I52BOFWbyYdRlk/uHAOTqSyDRu78qU9skPcDO6h3TI6t9WXhvgkwfHucSefSs89+gwOIuhcYqIL0NKJnd6qtnSn9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006583; c=relaxed/simple;
	bh=1ZtpFPKdlEgIIzEYrpUsaWuCkcuVgsVZSvTnHVeHq5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZ4wbiSDSyTHeoxJGP+2uJnuRSSf2aQcNSRLvA2YNTxkYIqgSQdwJavOTBIATBNu+Dd5ipl/tBKlj6dXLhDhKKAjiKFqgqaydj1amVV5X6r7vwN+yJr/UPF7F6Gm/RPvYu/3wYIFHx2d9j2ndcpJCzf8byzuZ7fRANfQImrdHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EViqiBNK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EViqiBNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790006580; x=1821542580;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1ZtpFPKdlEgIIzEYrpUsaWuCkcuVgsVZSvTnHVeHq5o=;
  b=EViqiBNKXkTQB+M1nNZ52MeYhQe/KV25GcdBvz6TmIvNT6eGxqsxMV0h
   wlFRb7vIIuu7TxrRjEOJQkc+K1YyGEImXu/ohOLWtS3ZhHsiOlHqiidvn
   71wvj0LJDYvwEZAw6RMqv1IbpP7mv+YxsxVISsRVwW68ep/98fgj3Cxza
   Yxj316k7mFRXip1CSnCopVb0mJCW75eSZpoOH2xoR/OjyMRbZ6XyOCIVc
   gpWrsVsR70czg7PoA/xYvG5z61TTXCyLsKO0pEHCU9N78UJBW64gxoOMb
   baoyjVRcXe6UHPEaMTxeAhV56CAULSgIrm9djHWQ/HhR+qFDMGwF/42Yt
   A==;
X-CSE-ConnectionGUID: 5UkGEkYKRUidZ0GOo6nvBg==
X-CSE-MsgGUID: QhBxmkqnR4+AmWvPm+8mSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="108036032"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="108036032"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 09:02:59 -0700
X-CSE-ConnectionGUID: sUS2XHXcTEunHZGo7VvnSA==
X-CSE-MsgGUID: vplJ1Gt9SLeC7a4nxNrQ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="269237542"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.94.252.97]) ([10.94.252.97])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 09:02:57 -0700
Message-ID: <a37799a1-8b41-4a8d-a350-9f4f913330f3@linux.intel.com>
Date: Mon, 21 Sep 2026 18:02:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/12][pull request] ice: Add ACL support
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
Cc: aleksandr.loktionov@intel.com, sandeep.penigalapati@intel.com,
 ananth.s@intel.com, alexander.duyck@gmail.com
References: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I see 0/9/18/2 issues were found by one of the sashikos [1] (other one still
embargoed), I assume some of them are valid. I will be analyzing and fixing
these for next version, unless all are false positives (unlikely).
For reference, previous version tally was 2/20/8/1 [2].

Thanks,
Marcin

[1] https://sashiko.dev/#/patchset/20260917183927.2692068-1-anthony.l.nguyen%40intel.com
[2] https://sashiko.dev/#/patchset/20260603220828.829969-1-anthony.l.nguyen%40intel.com

On 17.09.2026 20:39, Tony Nguyen wrote:
> Marcin Szycik says:
> 
> E8xx hardware provides a Ternary Classifier block for implementing
> functions such as ACL (Access Control List). In this series it's simply
> referred to as "ACL".
> 
> Implement ACL filtering. This expands support of network flow classification
> rules for the ethtool ntuple command. ACL filtering allows for an ip or port
> field's optional mask to be specified.
> 
> Example filters:
>   ethtool -N eth0 flow-type tcp4 dst-port 8880 m 0x00ff action 10
>   ethtool -N eth0 flow-type tcp4 src-ip 192.168.0.55 m 0.0.0.255 action -1
> 
> This is a resurrection of an old series from 2020 [1] with several
> improvements, but the fundamental logic unchanged. v1 was almost pulled
> in, but ultimately it was decided to drop it [2] because of unresolved
> issues. One issue was too many defensive NULL checks. Second issue is
> about inconsistency when using multiple input sets. Both are addressed
> in this patchset.
> 
> More about the second issue:
> 
> From [3]:
>> I would argue that you need to have some sort of logic that basically
>> checks to see if you are going to hit the input set issue and falls
>> back and applies the ACL rules. Otherwise you are significantly
>> hampering the usefulness of this filter type. It doesn't make sense
>> that dropping a field will cause a rule to fail to be added, but
>> masking a single bit in some field will make it valid. It would make
>> it a nightmare to use from the user point of view as the rules come
>> across as arbitrary.
> 
> Flow Director (FD) has a hardware limitation where all filters for the same
> packet type must use identical input sets. Previously, attempting to add the
> second filter would fail.
> 
> Patch 12 adds automatic fallback to ACL block when FD cannot accommodate a
> filter due to input set conflicts, which resolves this inconsistency.
> 
> [1] https://lore.kernel.org/intel-wired-lan/20200914153720.48498-1-anthony.l.nguyen@intel.com
> [2] https://lore.kernel.org/netdev/7192efe4d27c93148b3205e65f37203c89170316.camel@intel.com/#t
> [3] https://lore.kernel.org/netdev/CAKgT0Ucxd5-gvEwWAdbL04ER2o++RX_oekUV3E0rYquEgFKj1w@mail.gmail.com
> ---
> v2:
>   The biggest change is the addition of proper reset handling, which was
>   apparently mostly missing in the original code - see patch 10
> * Add patches 2 and 10
> Patch 1:
> * Rename fdir_active_fltr to ntuple_active_fltr_cnt, as it will
>   track the sum of fdir and ACL filters in future patches
> * Rename ice_fdir_update_cntrs() to ice_ntuple_update_cntrs(),
>   move it to ice_ethtool_ntuple.c, and make it static. In future patches
>   it will handle both fdir and ACL
> * ice_ntuple_update_cntrs(): join variable initialization and declaration
> Patch 3:
> * Remove example ethtool filters from commit message, as the feature is not
>   fully implemented at this point in the patchset. Moved this part to
>   the commit that finalizes functional implementation
> * ice_acl_create_tbl():
>   * fill num_dependent_alloc_ids with actual value, not always
>     ICE_AQC_MAX_CONCURRENT_ACL_TBL
>   * fill remaining alloc_ids with ICE_AQC_CONCURR_ID_INVALID (was unused
>     in previous versions and remaining alloc_ids left with 0)
>   * struct ice_acl_tbl_params has a new member num_dep_tbls for tracking
>     the number of dependent tables. This new member is explicitly set to
>     0 in the only caller, for clarity.
>   * Note that the only caller (ice_init_acl()) doesn't use concurrent
>     tables, so this specific configuration is currently unused
> * ice_acl_create_tbl(): move alloc_id check against ICE_AQC_ALLOC_ID_4K
>   to the success path, as the AQ command might complete successfully
>   with alloc_id set to below this value to indicate allocation failure.
>   Also, the AQ command might fail in a way that leaves the response
>   buffer invalid. IOW - the check was meaningless
> * ice_acl_create_tbl(): add unroll of ice_aq_alloc_acl_tbl() -
>   ice_aq_dealloc_acl_tbl()
> * ice_init_features(): remove ICE_FLAG_FD_ENA flag dependency on ACL
>   init. ACL should not be blocked by fdir being disabled
> * Add ice_acl_create_hw(). For now it's just called from ice_init_acl(),
>   but will be reused in the rebuild path in the future
> Patch 4:
> * Make ice_acl_rem_flows() non-static. Remove its call from
>   ice_vsi_manage_fdir(), instead call it from ice_deinit_acl()
> * ice_fdir_del_all_fltrs(), ice_fdir_replay_fltrs(): skip ACL filters
> Patch 5:
> * ice_{add,del}_ntuple_ethtool(): remove dependency on ICE_FLAG_FD_ENA.
>   ACL should not be blocked by fdir being disabled
> * ice_acl_prof_add_ethtool(): don't free and NULL hw_prof on existing
>   seg mismatch. This prevents deallocating an existing hw_prof, also
>   leaking its seg
> Patch 8:
> * Move ICE_ACL_INVALID_SCEN definition to ice_acl.h - will be used by
>   other files
> * Add ice_acl_set_act_drop() and ice_acl_set_act_fwd_queue() helpers -
>   will be useful later
> * ice_flow_add_entry(): add entry list head initialization. In this
>   patch it may be possible to have a NULL dereference when deleting
>   entry, because it may not have been added to the list. This is handled
>   in one of the following patches, but adding init won't hurt.
> Patch 9:
> * ice_flow_rem_prof_sync(): reset profile extraction if it's unused
>   after removal
> * ice_ntuple_update_list_entry(): add a missing ice_fdir_rem_flow() call
>   for ACL filter
> * ice_acl_rem_entry(): set err in loops only on failure. This way, AQ
>   commands succeeding in the end won't override errors in the middle.
>   Final cleanup of entry index will now only happen if all AQ writes
>   succeeded
> * ice_acl_add_rule_ethtool(): remove old entry when updating an entry
>   (same filter location). Without it, old entry remains in hw after
>   update, in addition to the new entry. Repro:
>     ethtool -N $PF1 flow-type tcp4 src-port 8080 m 0x0fff action -1 loc 5
>     ethtool -N $PF1 flow-type tcp4 src-port 9090 m 0x0fff action -1 loc 5
>     ethtool -N eth0 delete 5
> * ice_flow_acl_add_scen_entry_sync(): free hw counters in exchange
>   actions and if the entry is being disregarded deallocated. This was
>   previously done in a later patch, but makes more sense here.
> * ice_flow_add_entry(): same as above, move the change from future
>   patch here
> * ice_flow_acl_add_scen_entry_sync(): store entry ID so it can be
>   properly deleted later
> * ice_flow_acl_add_scen_entry_sync(): zero e->acts_cnt on success, so
>   that ice_flow_acl_free_act_cntr() will be skipped. On failure, free
>   exist->acts so exist won't carry stale counter references
> * Add ethtool command examples to commit message (moved from patch 2)
> Patch 11:
> * ice_flow_acl_add_scen_entry_sync(), ice_flow_add_entry():
>   ice_flow_acl_free_act_cntr() additions make more sense in patch adding
>   this code, move them to that patch. Now this patch is a pure refactor.
> Patch 12:
> * ice_fdir_has_input_set_conflict(): add a check if aRFS is using perfect
>   filters that may cause a conflict
> * ice_add_ntuple_ethtool(): add a guard that rejects flex-byte (user-def)
>   filters when they would be routed to ACL (since ACL ignores the flex
>   constraint, it would silently offload a broader rule)
> * ice_add_ntuple_ethtool(): join subsequent conditions that call
>   ice_acl_add_rule_ethtool() for clarity
> 
> v1: https://lore.kernel.org/netdev/20260603220828.829969-11-anthony.l.nguyen@intel.com/
> 
> The following are changes since commit 26ee8cd69d46a14b37ba5e512084fe80d730127a:
>   net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE
> 
> Lukasz Czapnik (1):
>   ice: use ACL for ntuple rules that conflict with FDir
> 
> Marcin Szycik (5):
>   ice: remove unused ICE_FD_FLUSH_REQ from PF state
>   Revert "ice: remove unused ice_flow_entry fields"
>   ice: use plain alloc/dealloc for ice_ntuple_fltr
>   ice: add ACL reset recovery and NTUPLE feature toggle
>   ice: re-introduce ice_dealloc_flow_entry() helper
> 
> Real Valiquette (5):
>   ice: initialize ACL table
>   ice: initialize ACL scenario
>   ice: create flow profile
>   ice: create ACL entry
>   ice: program ACL entry
> 
> Tony Nguyen (1):
>   ice: rename shared Flow Director functions and structs
> 
>  drivers/net/ethernet/intel/ice/Makefile       |    5 +-
>  drivers/net/ethernet/intel/ice/ice.h          |   27 +-
>  drivers/net/ethernet/intel/ice/ice_acl.c      |  486 +++++++
>  drivers/net/ethernet/intel/ice/ice_acl.h      |  177 +++
>  drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 1140 +++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_acl_main.c |  464 ++++++
>  drivers/net/ethernet/intel/ice/ice_acl_main.h |   10 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  393 ++++-
>  drivers/net/ethernet/intel/ice/ice_arfs.c     |    8 +-
>  drivers/net/ethernet/intel/ice/ice_arfs.h     |    2 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   13 +-
>  ...ce_ethtool_fdir.c => ice_ethtool_ntuple.c} |  817 ++++++++---
>  drivers/net/ethernet/intel/ice/ice_fdir.c     |   41 +-
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |   16 +-
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    |   11 +-
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |    2 +
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 1267 ++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_flow.h     |   39 +-
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |    3 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      |   10 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  162 ++-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   14 +-
>  drivers/net/ethernet/intel/ice/virt/fdir.c    |   32 +-
>  23 files changed, 4859 insertions(+), 280 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_main.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_main.h
>  rename drivers/net/ethernet/intel/ice/{ice_ethtool_fdir.c => ice_ethtool_ntuple.c} (74%)
> 

